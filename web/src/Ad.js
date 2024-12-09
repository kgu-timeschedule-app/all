import "./App.css";
import Typography from "@material-ui/core/Typography";
import { useLocation } from "react-router-dom";
import { Helmet, HelmetProvider } from "react-helmet-async";
import SearchResult from "./SearchResult";
import { Box } from "@material-ui/core";

export default function Ad(props) {
  let ad_data = [
    "",
    "神学部／School of Theology",
    "文学部／School of Humanities",
    "社会学部／School of Sociology",
    "法学部／School of Law and Politics",
    "経済学部／School of Economics",
    "商学部／School of Business Administration",
    "理工学部／School of Science and Technology",
    "総合政策学部／School of Policy Studies",
    "人間福祉学部／School of Human Welfare Studies",
    "教育学部／School of Education",
    "国際学部/International Studies／School of International Studies",
    "理学部／School of Science",
    "工学部／School of Engineering",
    "生命環境学部／School of Biological and Environmental Sciences",
    "建築学部／School of Architecture",
    "使用しない（カリキュラム設定用　非正規　大学",
    "スポーツ科学・健康科学教育プログラム室／Sports and Health Sciences Program Office",
    "共通教育センター／Center for Common Educational Programs",
    "キャリアセンター／Center for Career Planning and Placement",
    "共通教育センター（情報科学科目）／Center for Common Educational Programs (Information Science Courses)",
    "言語教育研究センター／Language Center",
    "国際教育・協力センター（CIEC　JEASP）／Center for International Education and Cooperation (JEASP)",
    "教職教育研究センター（資格）／Research Center for Teacher Development (for Certifications)",
    "教職教育研究センター（教職専門）／Research Center for Teacher Development (for Special Studies)",
    "国際教育・協力センター/CIEC／Center for International Education and Cooperation",
    "キリスト教と文化研究センター／Research Center for Christianity and Culture",
    "日本語教育センター／Center for Japanese Language Education",
    "ハンズオン・ラーニングセンター／Center for Hands-on Learning Programs",
    "国連・外交統括センター／Integrated Center for UN and Foreign Affairs Studies",
    "神学研究科前期／Graduate School of Theology Master&#39;s Course",
    "文学研究科前期／Graduate School of Humanities Master&#39;s Course",
    "社会学研究科前期／Graduate School of Sociology Master&#39;s Course",
    "法学研究科前期／Graduate School of Law and Politics Master&#39;s Course",
    "経済学研究科前期／Graduate School of Economics Master&#39;s Course",
    "商学研究科前期／Graduate School of Business Administration Master&#39;s Course",
    "理工学研究科前期／Graduate School of Science and Technology Master&#39;s Course",
    "総合政策研究科前期／Graduate School of Policy Studies Master&#39;s Course",
    "言語コミュニケーション前期／Graduate School of Language, Communication, and Culture Master&#39;s Course",
    "人間福祉研究科前期／Graduate School of Human Welfare Studies Master&#39;s Course",
    "教育学研究科前期／Graduate School of Education Master&#39;s Course",
    "理工学研究科修士／Graduate School of Science and Technology Master&#39;s Course",
    "国際学研究科前期／Graduate School of International Studies Master&#39;s Course",
    "大学院共通科目・認定科目前期／Graduate School of Master&#39;s Course (Certified)",
    "神学研究科後期／Graduate School of Theology Doctoral Course",
    "文学研究科後期／Graduate School of Humanities Doctoral Course",
    "社会学研究科後期／Graduate School of Sociology Doctoral Course",
    "法学研究科後期／Graduate School of Law and Politics Doctoral Course",
    "経済学研究科後期／Graduate School of Economics Doctoral Course",
    "商学研究科後期／Graduate School of Business Administration Doctoral Course",
    "理工学研究科後期／Graduate School of Science and Technology Doctoral Course",
    "総合政策研究科後期／Graduate School of Policy Studies Doctoral Course",
    "言語コミュニケーション後期／Graduate School of Language, Communication, and Culture Doctoral Course",
    "人間福祉研究科後期／Graduate School of Human Welfare Studies Doctoral Course",
    "教育学研究科後期／Graduate School of Education Doctoral Course",
    "経営戦略研究科後期／Graduate School of Institute of Business and Accounting Doctoral Course",
    "国際学研究科後期／Graduate School of International Studies Doctoral Course",
    "大学院共通科目・認定科目後期／Graduate School of Doctoral Course (Certified)",
    "司法研究科／Law School",
    "経営戦略研究科/IBA／Institute of Business and Accounting",
    "使用しない（カリキュラム設定用　非正規　大学院）",
  ];

  const location = useLocation();
  const id = location.pathname.replace("/ad/", "");
  return (
    <div>
       <HelmetProvider>
      <Helmet>
        <title>{ad_data[id] + "授業一覧"}</title>
        <meta name="description" content={ad_data[id] + "の授業一覧です。"} />
        <link rel="canonical" href={"https://kgu-syllabus.com/ad/" + id} />
      </Helmet></HelmetProvider>
      <Box my={3} ml={3}>
        <Typography variant="h2" component="h1">
          {ad_data[id]}の授業一覧
        </Typography>
        <Box mt={3}>
        <Typography variant="subtitle2">
          検索結果が何も表示されない場合は下の青色の「検索」ボタンを再度押してください。
        </Typography>
        </Box>
      </Box>
      <SearchResult
        all=""
        ad={parseInt(id)}
        term=""
        score=""
        campas=""
        day=""
        downloadedData={props.data}
      />
    </div>
  );
}
