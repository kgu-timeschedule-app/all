import { useHistory } from "react-router-dom";

export default function NoMatch() {
  const history = useHistory();
  history.push({
    pathname: "/404.html",
  });
  window.location.reload();
  return <p>404 error.</p>;
}