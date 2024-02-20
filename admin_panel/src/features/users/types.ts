export interface User {
  _id?: string;
  userName: string; 
  description: string;
}

export interface UserState {
  users: User[]; 
  status: "idle" | "loading" | "succeeded" | "failed";
  error: string | null;
  selectedUser: User | null; // for editing
}
