/* eslint-disable no-sequences */
import "./App.css";
import "./sp.css";
import "./top.css";
import Typography from "@material-ui/core/Typography";
import { Box } from "@material-ui/core";
import { makeStyles, useTheme } from "@material-ui/core/styles";
import Paper from "@material-ui/core/Paper";
import SearchForm from "./SearchForm";
import useMediaQuery from "@material-ui/core/useMediaQuery";
import React from "react";
import Grid from "@material-ui/core/Grid";
import Link from "@material-ui/core/Link";
import Card from "@material-ui/core/Card";
import CardContent from "@material-ui/core/CardContent";
import { Helmet, HelmetProvider } from "react-helmet-async";

const useStyles = makeStyles((theme) => ({
  panel: {
    backgroundColor: "#F4F4F4",
    borderRadius: "16px!important",
  },
  textfield: {
    backgroundColor: "#FFFFFF",
    borderRadius: "16px",
  },
  text: {
    color: "rgb(42, 42, 46)",
  },
  text3: {
    color: "rgb(46, 46, 46)",
    fontWeight: "bold",
  },
  text2: {
    color: "rgb(42, 42, 46)",
    padding: "2rem 0px 0px 0px",
  },
  textEvent: {
    color: "white",
    fontSize: "22px",
  },
  textEventImp: {
    fontSize: "28px",
  },
  alert: {
    position: "fixed",
    bottom: "50px",
    left: "30px",
  },
  a8: {
    width: "100%",
  },
  no_margin: {
    margin: "0px",
  },
  applink: {
    display: "inline-block",
    overflow: "hidden",
    paddingRight: "10px",
  },
  googlelink: {
    display: "inline-block",
    overflow: "hidden",
    paddingRight: "10px",
  },
  appimage: {
    paddingBottom: "4.3px",
    width: "140px",
    height: "auto",
  },
  googleimage: {
    width: "160px",
    height: "auto",
  },
}));
export default function Search(props) {
  const classes = useStyles();
  const theme = useTheme();
  const matches = useMediaQuery(theme.breakpoints.up("sm"));
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

  return (
    <div>
      <HelmetProvider>
        <Helmet>
          <title>
            【超高速】関西学院大学 非公式シラバス 情報検索ツール/Syllabus
          </title>
          <meta
            name="description"
            content="2024年度の関西学院大学(関学)の非公式シラバス情報照会ページです。公式ではありませんが、本家より検索速度が速く、ログインすると時間割の登録ができ、教科書や参考書、テストのデータを一覧で出力できます。"
          />
          <link rel="canonical" href="https://kgu-syllabus.com/search" />
        </Helmet>
      </HelmetProvider>
      <Box px={{ xs: 1, md: 16 }} pt={{ xs: 0, md: 0 }}>
        <Box px={{ md: 0 }} textAlign="center">
          {(() => {
            if (matches) {
              return (
                <Typography
                  variant="h1"
                  className={classes.text2}
                  component="h1"
                >
                  授業検索システム
                </Typography>
              );
            } else {
              return;
            }
          })()}
          <Typography variant="body1" className={classes.text}>
            {/* <p className={classes.no_margin}>申し込み科目受付終了まで</p> */}
            {/* <iframe title="timer" src="https://countdown.reportitle.com/neo_parts.php?year=2023&month=9&day=9&hour=16&minute=0&centi=5&cnt1=%E6%97%A5&cnt2=%E6%99%82%E9%96%93&cnt3=%E5%88%86&cnt4=%E7%A7%92&br1=&br2=&br3=&br4=&com1=&com2=&com3=&com4=%E9%81%A9%E5%BD%93%E3%81%AB%E3%82%AB%E3%82%A6%E3%83%B3%E3%83%88%E3%82%A2%E3%83%83%E3%83%97%E4%B8%AD&end=1&height=150&font=arial&size=18&t_size=35&l_height=27&t_height=30&bold=&italic=&line=&space=&align=2&img=&color1=000000&color2=ff0000&color3=f8f8f8&roop=&convert=0&baseoffset=-9&font2=0&cuttime=1&surl=1"></iframe> */}
                {/* <a href="https://www.kwansei.ac.jp/cms/about/calendar/UG_schedule2023.pdf"
                target="_blank"
                rel="noreferrer">
                その他の履修スケジュール
                 </a> */}
                <Typography variant="body2" className={classes.text}>
                <a href="https://kwic.kwansei.ac.jp/portal/home"
              target="_blank"
              rel="noreferrer">Kwic</a>
              &emsp;&emsp;&emsp;
              <a href="https://luna.kwansei.ac.jp/lms/timetable"
              target="_blank"
              rel="noreferrer">Luna(時間割)</a>
              &emsp;&emsp;&emsp;
              <a href="https://luna-old.kwansei.ac.jp/"
              target="_blank"
              rel="noreferrer">Luna(旧)<br /></a>
             &emsp;&emsp;&emsp;
              <a
                href="https://kg-course.kwansei.ac.jp/"
                target="_blank"
                rel="noreferrer"
              >
                履修登録 / 申請 / 成績確認ポータル
              </a>
            </Typography>
            
            <Typography variant="body2" className={classes.text3}>
              シラバス検索&時間割アプリは以下リンクから！<br />
              （シラバスのあいまい検索/授業の登録が簡単で教科書/テスト情報）
            </Typography>
            <a href="https://apps.apple.com/jp/app/%E9%96%A2%E5%AD%A6%E7%94%9F%E9%99%90%E5%AE%9A-%E6%99%82%E9%96%93%E5%89%B2%E3%82%A2%E3%83%97%E3%83%AA/id6444226126?itsct=apps_box_badge&amp;itscg=30200"
              target="_blank"
              rel="noreferrer">Apple Store</a>
              &emsp;&emsp;&emsp;
<a href="https://play.google.com/store/apps/details?id=io.timeschedule.kgu&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1"
              target="_blank"
              rel="noreferrer">Google Play</a>
        </Typography>
          <Box pt={1}>
            <Paper elevation={3} className={classes.panel}>
              <Typography variant="body1" className={classes.text}>
                検索フォーム (2024年度の授業に対応しました。)
              </Typography>
              <SearchForm data={props.data} short={false} />
            </Paper>
          </Box>
          <Box pt={{ xs: 6, md: 10 }} pb={{ xs: 8, md: 8 }}>
            {/* <Typography variant="h2" className={classes.text} component="h1">
              {matches ? "履修スケジュール" : "スケジュール"}
            </Typography> */}
            {/* <a href="KGU-schedule-spring-risyuu.ics" download="KGU-schedule-spring-risyuu.ics">自分のカレンダーに追加</a><br></br> */}
            {/* LINEのブラウザではダウンロードできません。safari, Chromeなどを使ってね！ */}

            {/* <Typography variant="h6" className={classes.text} component="h2">
             教科の情報のページはURLに授業IDの組み合わせで登録されています。
             授業IDで検索したい時にご使用ください。<br />
             教科IDが123456789の場合<br />
            URLはhttps://kgu.syllabus.com/subject/123456789
            </Typography>
          <Typography variant="h6" className={classes.text} component="h2">
            抽選科目は各学部の履修心得、もしくは<a href="https://kg-course.kwansei.ac.jp/uniasv2/UnSSOLoginControl2?REQ_LOGIN_NO=2&REQ_ACTION_DO=/ARC110.do&REQ_PRFR_MNU_ID=MNUIDSTD0102011">こちら</a>からご確認ください。
            </Typography>
            <Typography variant="h6" className={classes.text} component="h2">
              <a href="/">こちら</a>
              のページ下部にこのシラバスの詳しい使い方が書いてあります。合わせてご覧ください。
            </Typography> */}
          </Box>
        </Box>
      </Box>
      <Typography variant="h4" component="h1" align="center">
        2024年度の各学部の授業一覧
      </Typography>
      <Box my={5} mx={1}>
        <Grid container spacing={3}>
          {ad_data.map((value, index) => {
            if (value === "") {
              return <p></p>;
            } else {
              return (
                <Grid item xs={12} sm={4} key={index}>
                  <Link href={"/ad/" + index} key={index}>
                    <Card className={classes.root} key={index}>
                      <CardContent key={index}>
                        <Typography
                          variant="h6"
                          className={classes.t3}
                          component="h6"
                          align="center"
                          key={index}
                        >
                          {value.split("／")[0]}
                        </Typography>
                      </CardContent>
                    </Card>
                  </Link>
                </Grid>
              );
            }
          })}
        </Grid>
      </Box>
    </div>
  );
}
