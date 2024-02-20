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