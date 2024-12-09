import Typography from "@material-ui/core/Typography";
import { Helmet, HelmetProvider } from "react-helmet-async";

export default function Allpages(props) {
  return (
    <div>
       <HelmetProvider>
      <Helmet>
        <title>サイトマップ / 非公式シラバス 情報検索ツール/Syllabus</title>
        <link rel="canonical" href="https://kgu-syllabus.com/allpages" />
      </Helmet></HelmetProvider>
      <Typography variant="h4">
        URL一覧.
        {Object.keys(props.data).map((key, index) => {
          return (
            <div key={index + 1}>
              <a key={index + 1} href={`https://kgu-syllabus.com/subject/${key}`}>{key}</a>
            </div>
          );
        })}
      </Typography>
    </div>
  );
}
