export interface Category {
  _id?: string;
  categoryName: string;
  description: string;
}

export interface CategoryState {
  categories: Category[];
  status: "idle" | "loading" | "succeeded" | "failed";
  error: string | null;
  selectedCategory: Category | null;
}
