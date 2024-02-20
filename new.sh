#!/bin/bash

# Proje adını dışarıdan parametre olarak al veya kullanıcıdan iste
PROJECT_NAME=${1:-$(
  read -p "Proje adı girilmedi. Lütfen bir proje adı girin: " REPLY
  echo $REPLY
)}

# Eğer proje adı hala boşsa, scripti sonlandır
if [ -z "$PROJECT_NAME" ]; then
  echo "Proje adı girilmedi. Script sonlandırılıyor."
  exit 1
fi

# react projesi oluşturma işlemi
npx create-react-app "$PROJECT_NAME" --template typescript

# Proje dizinine git
cd "$PROJECT_NAME"

cat >.env <<EOF
REACT_APP_BASE_URL=http://localhost:3000
REACT_APP_REMOTE_SERVICE_BASE_URL=http://localhost:5000
EOF

# Gerekli npm paketlerini kur
npm install axios @reduxjs/toolkit react-redux react-router-dom @types/react-redux @types/react-router-dom

# Önceden belirlenmiş dizinleri oluştur
mkdir -p src/{library,app,features/{categories,products},layout/{header,footer,sidebar,content},common/{components,hooks,utils}}

# reducer, store ve layout component dosyalarını oluştur
touch src/app/{store.ts,rootReducer.ts} \
  src/layout/{Header/index.tsx,Footer/index.tsx,Sidebar/index.tsx,Content/index.tsx,index.tsx} \
  src/features/categories/{index.tsx,create.tsx,update.tsx,categorySlice.ts,types.ts}

# appconsts
cat >src/library/appconsts.ts <<EOF
const AppConsts = {
  appBaseUrl: process.env.REACT_APP_BASE_URL,
  remoteServiceBaseUrl: process.env.REACT_APP_REMOTE_SERVICE_BASE_URL,
};
export default AppConsts;
EOF

# src/common/utils/interceptors.ts
cat >src/common/utils/interceptors.ts <<EOF
export const requestInterceptor = (config: any) => {
  localStorage.setItem("token", "shumen istedi ondan dolayı yazıyoruz");

  const token = localStorage.getItem("token");
  if (token) {
    config.headers.Authorization = \`Bearer \${token}\`;
  }
  return config;
};

export const requestErrorInterceptor = (error: any) => Promise.reject(error);
export const responseInterceptor = (response: any) => response;

export const responseErrorInterceptor = (error: any) => {
  if (error.response.status === 401) {
    localStorage.removeItem("token");
  }
  return Promise.reject(error);
};
EOF

# src/common/utils/api.ts
cat >src/common/utils/api.ts <<EOF
import axios from "axios";
import qs from "qs";
import AppConsts from "../../library/appconsts";

import {
  requestInterceptor,
  requestErrorInterceptor,
  responseErrorInterceptor,
  responseInterceptor,
} from "./interceptors";

const http = axios.create({
  baseURL: AppConsts.remoteServiceBaseUrl,
  headers: { "Content-Type": "application/json" },
  timeout: 30000,
  paramsSerializer: (params) => {
    return qs.stringify(params, { encode: false });
  },
});

// http.interceptors.request.use(
//   (config) => {},
//   (error) => {}
// );
// http.interceptors.response.use(
//   (response) => {},
//   (error) => {}
// );

http.interceptors.request.use(requestInterceptor, requestErrorInterceptor);
http.interceptors.response.use(responseInterceptor, responseErrorInterceptor);

export default http;
EOF

# Modeller için döngü
models=("Category" "Product") # Model listesini buraya ekleyin
for model in "${models[@]}"; do
  pluralModel="${model}s"
  [[ "$model" == "Category" ]] && pluralModel="Categories" # Özel durum

  # Model için klasör oluştur ve types.ts dosyasını doldur
  mkdir -p "src/features/${pluralModel,,}"
  cat >"src/features/${pluralModel,,}/types.ts" <<EOF
export interface ${model} {
  _id?: string;
  // TODO: Model alanları
}

export interface ${model}State {
  ${pluralModel,,}: ${model}[];
  status: "idle" | "loading" | "succeeded" | "failed";
  error: string | null;
  selected${model}: ${model} | null;
}
EOF
  echo "${model} types.ts dosyası oluşturuldu: src/features/${pluralModel,,}/types.ts"
done

# rootReducer ve store dosyalarını doldur
cat >src/app/rootReducer.ts <<EOF
import { combineReducers } from '@reduxjs/toolkit';
import categoryReducer from '../features/categories/categorySlice';

const rootReducer = combineReducers({
  category: categoryReducer,
});

export default rootReducer;
EOF

cat >src/app/store.ts <<EOF
import { configureStore } from '@reduxjs/toolkit';
import rootReducer from './rootReducer';

const store = configureStore({
  reducer: rootReducer,
});

export type AppDispatch = typeof store.dispatch;
export type RootState = ReturnType<typeof store.getState>;

export default store;
EOF

cat >src/features/categories/categorySlice.ts <<EOF
import { createSlice, createAsyncThunk } from "@reduxjs/toolkit";
import { RootState } from "../../app/store";
import http from "../../common/utils/api";
import { CategoryState, Category } from "./types";

const initalState: CategoryState = {
  categories: [],
  status: "idle",
  error: null,
  selectedCategory: null,
};

// async action to fetch by id
export const fetchCategoryById = createAsyncThunk<
  Category,
  number,
  {
    rejectValue: string; // red edilme durumunda, response'un içindeki error mesajını almak için
    state: RootState; // thunk içinde state'e erişmek için
  }
>("categories/fetchCategoryById", async (id, { rejectWithValue }) => {
  try {
    const response = await http.get(`/categories/${id}`); 
    return response.data;
  } catch (error: any) {
    return rejectWithValue(error.response.data.message);
  }
});

export const fetchCategories = createAsyncThunk("/categories", async () => {
  const response = await http.get("/categories");
  return response.data;
});

const categorySlice = createSlice({
  name: "categories",
  initialState: initalState,
  reducers: {},
  extraReducers: (builder) => {
    builder.addCase(fetchCategoryById.fulfilled, (state, action) => {
      state.selectedCategory = action.payload;
    });

    builder.addCase(fetchCategories.fulfilled, (state, action) => {
      state.categories = action.payload;
    });
  },
});

export default categorySlice.reducer;

// fetchCategoryById thunk'ı başarılı olursa, yapılacak olan işlemlerini var ise, buraya yazabilirsin.

// builder.addCase(fetchCategoryById.pending, (state, action) => {}); // bekleme durumnda yapılacak olan işlemlerini var ise, buraya yazabilirsin.
// builder.addCase(fetchCategoryById.rejected, (state, action) => {}); // red edilme durumunda yapılacak olan işlemlerini var ise, buraya yazabilirsin.

EOF
echo "Proje yapılandırması tamamlandı."

 