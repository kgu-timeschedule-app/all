import "./App.css";
import Typography from "@material-ui/core/Typography";
import { makeStyles } from "@material-ui/core/styles";
import { Box} from "@material-ui/core";

const useStyles = makeStyles((theme) => ({
  footer:{
    backgroundColor: "#686868",
    color: "white!important",
    textAlign: "center",
    fontWeight: "500"
  }
}));

export default function Main() {
  const classes = useStyles();
  return (
    <div>
      <Box mt={5} pb={2} pl={2} className={classes.footer}>
        <Typography variant="body1" className={classes.footer}>
          このサイトの改善点や評価等なにかあれば、左下の赤いマークを押すとサイト製作者に連絡することができます。<br />
          ダウンロードをする際は自己責任でお願いします。< br />
          シラバスのデータは自動で最新のものに更新されています。<br />
          GAなどのデータ取得についてのプライバシーポリシーは<a href="https://kgu-syllabus.com/privacy">こちら</a>です。<br />
          Made by <a href="https://tanemura.dev">Keito Tanemura</a>(総合政策学部メディア情報学科) ktanemura[at]kwansei.ac.jp
        </Typography>
        このシラバスのサイト一覧は<a href="https://kgu-syllabus.com/allpages">こちら</a>
      </Box>
    </div>
  );
}
