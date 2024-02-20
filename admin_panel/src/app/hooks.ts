import { TypedUseSelectorHook, useDispatch } from "react-redux";
import { AppDispatch, RootState } from "./store";
import { useSelector } from "react-redux";

export const UserAppDispatch = () => useDispatch<AppDispatch>;
export const UseAppSelector: TypedUseSelectorHook<RootState> = useSelector;
