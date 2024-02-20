export interface Product {
  _id?: string;
  productName: string; 
  description: string;
}

export interface ProductState {
  products: Product[]; 
  status: "idle" | "loading" | "succeeded" | "failed";
  error: string | null;
  selectedProduct: Product | null; // for editing
}
