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

./npm/index.sh