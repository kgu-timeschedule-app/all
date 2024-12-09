import "./App.css";
import Typography from "@material-ui/core/Typography";
import { makeStyles } from "@material-ui/core/styles";
import { Box} from "@material-ui/core";
import DoneIcon from "@material-ui/icons/Done";
import Button from "@material-ui/core/Button";
import Card from "@material-ui/core/Card";
import CardContent from "@material-ui/core/CardContent";
import Grid from "@material-ui/core/Grid";
import Explain from "./Explain";
import AnchorLink from "react-anchor-link-smooth-scroll";
import { Helmet, HelmetProvider } from "react-helmet-async";
import {isWebpSupported} from 'react-image-webp/dist/utils';
import SearchIcon from '@material-ui/icons/Search';
import CardActionArea from '@material-ui/core/CardActionArea';

const useStyles = makeStyles((theme) => ({
  topimage: {
    width: "90vw",
    marginLeft: "10vw",
    position: "absolute",
    zIndex: "-1",
  },
  top: {
    width: "100vw",
    backgroundColor: "#000000ad",
    zIndex: "10",
  },
  text: {
    fontWeight: "700",
    color: "white",
    padding: "0",
  },
  sub: {
    color: "#5392F9",
  },
  tmp: {
    width: "100vw",
  },
  toptext: {
    paddingTop: "30vw",
  },
  bt: {
    marginLeft: "10px",
  },
  small: {
    color: "#5392F9",
    fontWeight: "700",
    fontSize: "24px",
  },
  small2: {
    color: "#5392F9",
    fontWeight: "700",
    fontSize: "24px",
    display: "block",
  },
  t2: {
    color: "#DDDDDD",
    fontWeight: "700",
  },
  t3: {
    color: "#3f9863",
    fontWeight: "700",
  },
  icon: {
    verticalAlign: "sub",
  },
  line: {
    width: "24%",
  },
  eximg: {
    width: "100%",
  },
  dp: {
    display: "block",
  },
  cardtouch: {
    backgroundColor: "#5392F9"
  },
  type:{
    color: "white",
  },
  adjust:{
    fontSize: "48px",
    verticalAlign: "text-bottom"
  },
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
       <HelmetProvider>
      <Helmet>
        <meta
          name="description"
          content="2022年度の関西学院大学(関学)の非公式シラバストップページです。高速で検索でき、授業をレビューできる非公式のシラバス情報検索ツールです。このページでは当シラバスの使用方法やログイン方法について記載しています。"
        />
        <link rel="canonical" href="https://kgu-syllabus.com" />
      </Helmet></HelmetProvider>
      <div className={classes.top}>
        <div className={classes.tmp}>
          {isWebpSupported() ? <img className={classes.topimage} src="top.webp" alt="トップページ" /> : <img className={classes.topimage} src="top.png" alt="トップページ" /> }
        </div>
        <div className={classes.toptext}>
          <Box mx={3} pb={3}>
            <Typography
              variant="body2"
              className={classes.small}
            >
              EASY TO SEARCH
            </Typography>
            <Typography variant="h1" className={classes.text} component="h1">
              関西学院大学専用シラバス
            </Typography>
            <Box my={2} ml={5}>
              <Typography variant="h6" className={classes.t2} component="h3">
                <DoneIcon className={classes.icon} />
                高速検索
              </Typography>
              <Typography variant="h6" className={classes.t2} component="h3">
                <DoneIcon className={classes.icon} />
                時間割登録
              </Typography>
              <Typography
                variant="body2"
                className={classes.t2}
                component="h3"
              >
                <DoneIcon className={classes.icon} />
                レビュー
              </Typography>
            </Box>
            <Box ml={{ xs: 2, sm: 4 }}>
              <Button variant="contained" color="primary" href="/search">
                授業を検索する！
              </Button>
            </Box>
          </Box>
        </div>
      </div>
      <Box my={3} mx={5}>
                <Card className={classes.cardtouch}>
                <CardActionArea href="/search">
                  <CardContent>
                    <Typography
                      variant="h2"
                      component="h2"
                      align="center"
                      className={classes.type}
                    >
                       ＞＞＞＞＞  <SearchIcon className={classes.adjust} />
                   授業を検索するならここをクリック！＜＜＜＜＜
                    </Typography>
                  </CardContent>
                  </CardActionArea>
                </Card>
                </Box>
      <Box my={5} mx={3}>
        <Typography
          variant="body2"
          className={classes.small2}
          align="center"
        >
          FUCTIONS
        </Typography>
        <Box mt={1} mb={2}>
          <Typography variant="h4" component="h2" align="center">
            既存のシラバス以上の機能
          </Typography>
        </Box>
        <hr className={classes.line}></hr>
        <Typography
          variant="body1"
          className={classes.dp}
          align="center"
        >
          機能をクリックすると機能の使い方を表示します。時間割登録機能は不人気なので、サービス中止しています。
        </Typography>
        <Box my={5}>
          <Grid container spacing={3}>
            <Grid item xs={12} sm={4}>
              <AnchorLink href="#1" offset="50">
                <Card className={classes.root}>
                  <CardContent>
                    <Typography
                      variant="h6"
                      className={classes.t3}
                      component="h2"
                      align="center"
                    >
                      検索(高速)
                    </Typography>
                  </CardContent>
                </Card>
              </AnchorLink>
            </Grid>

            {/* <Grid item xs={12} sm={4}>
              <AnchorLink href="#2" offset="50">
                <Card className={classes.root}>
                  <CardContent>
                    <Typography
                      variant="h6"
                      className={classes.t3}
                      component="h2"
                      align="center"
                    >
                      時間割機能(教科書一覧表示)
                    </Typography>
                  </CardContent>
                </Card>
              </AnchorLink>
            </Grid> */}

            <Grid item xs={12} sm={4}>
              <AnchorLink href="#3" offset="50">
                <Card className={classes.root}>
                  <CardContent>
                    <Typography
                      variant="h6"
                      className={classes.t3}
                      component="h2"
                      align="center"
                    >
                      レビュー、口コミ機能
                    </Typography>
                  </CardContent>
                </Card>
              </AnchorLink>
            </Grid>
          </Grid>
        </Box>
        
        <Box mt={5} pt={5}>
          <Explain
            id="1"
            titleen="HOW TO USE"
            title="関西学院大学専用シラバス"
            discription="たった３ステップで検索できます。"
            img1={isWebpSupported() ? <img src="ex1.webp" className={classes.eximg} alt="検索"/> :<img src="ex1.png" className={classes.eximg} alt="検索"/> }
            title1="検索"
            discription1="授業名、担当教授名（代表者）、キャンパス名、曜日をキーワードで検索することができます。検索されない場合は再度青い検索ボタンを押してください。漢字や読み方が分からない場合はローマ字で入力してください。"
            img2={isWebpSupported() ? <img src="ex2.webp" className={classes.eximg} alt="一覧表示"/> :<img src="ex2.png" className={classes.eximg} alt="一覧表示"/> }
            title2="一覧表示"
            discription2="検索結果が一覧で表示されます。該当の科目をクリックしてください。該当する科目がない場合は何も表示されません。上の検索バーより、検索項目を変更してみてください。"
            img3={isWebpSupported() ? <img src="ex3.webp" className={classes.eximg} alt="詳細表示"/> :<img src="ex3.png" className={classes.eximg} alt="詳細表示"/> }
            title3="詳細表示"
            discription3="教科の詳細が表示されます。"
          />
        </Box>
        {/* <Box mt={5} pt={5}>
          <Explain
            id="2"
            titleen="HOW TO CHECK"
            title="時間割の確認方法"
            discription="たった３ステップで時間割の登録ができます。"
            img1={isWebpSupported() ? <img src="time1.webp" className={classes.eximg} alt="ログイン" /> :<img src="time1.png" className={classes.eximg} alt="ログイン" />}
            title1="ログイン"
            discription1="画面右上のアイコンをクリックしたのち、お好きなログイン（Google, Twitter, Facebook)方法でログインをしてください。"
            img2={isWebpSupported() ? <img src="time2.webp" className={classes.eximg} alt="楽器選択画面" /> :<img src="time2.png" className={classes.eximg} alt="楽器選択画面" />}
            title2="学期選択画面"
            discription2="時間割を登録したい学期を選択し、「時間割を見る」をクリックしてください。"
            img3={isWebpSupported() ? <img src="time3.webp" className={classes.eximg} alt="詳細表示" /> :<img src="time3.png" className={classes.eximg} alt="詳細表示" />}
            title3="詳細表示"
            discription3="教科の詳細が表示されます。"
          />
        </Box> */}
        <Box mt={3}>
 <Button variant="contained" color="primary" href="/search">
            さっそく授業を検索する
          </Button>
          </Box>
        <Box mt={5} pt={5}>
          <Explain
            id="3"
            titleen="HOW TO REVIEW"
            title="修正及びレビューの方法"
            discription="簡単に追加、修正ができます。"
            img1={isWebpSupported() ? <img src="review1.webp" className={classes.eximg} alt="詳細表示" /> :<img src="review1.png" className={classes.eximg} alt="詳細表示" />}
            title1="検索"
            discription1="レビューを書く、評価する場合は教科のページに移動していだだき、画面中央の「評価する」ボタンをクリックし、評価をつけ、レビューを入力してください。レビューの文章に不適切な言葉が含まれていないか、AIが確認したのち、本サイトに公開されるため、公開されるまで30秒ほどお時間がかかる場合があります。ご了承ください。レビューをされる場合は事前にログインが必要です。"
          />
          <Button variant="contained" color="primary" href="/search">
            さっそく授業を検索する
          </Button>
          <Typography variant="body1" className={classes.dp}>
            当検索サイトをブックマークに登録するとより便利になります。
          </Typography>
        </Box>
      </Box>
    </div>
  );
}
