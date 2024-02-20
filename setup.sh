# proyenin adini xaricden alin enviroment variable olaraq set eder
PROJECT_NAME=$1

#Eger proyekt adi verilmeyibse istifadeciden projenin adini iste
if [ -z "$PROJECT_NAME" ]; then
echo "Projenin adini girilmelisiniz , xahis olunur adinizi daxil edin"
read PROJECT_NAME
fi

#react project yarat
npx create-react-app $PROJECT_NAME --template typescript

#project daxil olunmasi
cd $PROJECT_NAME

# ./npm/index.sh

npm install @reduxjs/toolkit 
npm install react-redux 
npm install react-router-dom 
npm install @types/react-redux 
npm install @types/react-router-dom

#fayl elave elesin
mkdir -p src/app \
  src/features/categories \
  src/layout \
  src/common/components \
  src/common/hooks \
  src/common/utils \
  src/layout/header \
  src/layout/footer \
  src/layout/sidebar \
  src/layout/content
#reducer ve store folderlerini yaradir
touch src/app/store.ts \
     src/app/rootReducer.ts 

#laylot componentlerini yaradir
touch src/layout/Header/index.tsx \
    src/layout/Footer/index.tsx \
    src/layout/Sidebar/index.tsx \
    src/layout/Content/index.tsx \
    src/layout/index.tsx 

#catogory componentleri yarador
touch src/features/categories/index.tsx \
 src/features/catagories/create.tsx \
 src/features/categories/update.tsx \
 src/features/categories/categorySlice.ts \
 src/features/categories/types.ts \


 cat >src/app/rootReducer.ts <<EOF

EOF

cat >src/app/store.ts <<EOF

EOF
