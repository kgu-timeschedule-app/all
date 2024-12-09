import "./App.css";
import Typography from "@material-ui/core/Typography";
import { makeStyles, useTheme } from "@material-ui/core/styles";
import AppBar from "@material-ui/core/AppBar";
import Toolbar from "@material-ui/core/Toolbar";
import Link from "@material-ui/core/Link";
import StyledFirebaseAuth from "react-firebaseui/StyledFirebaseAuth";
import firebase from "./firebasec_conf";
import "firebase/auth";
import React from "react";
import Dialog from "@material-ui/core/Dialog";
import DialogContent from "@material-ui/core/DialogContent";
import DialogContentText from "@material-ui/core/DialogContentText";
import DialogTitle from "@material-ui/core/DialogTitle";
import IconButton from "@material-ui/core/IconButton";
import AccountCircle from "@material-ui/icons/AccountCircle";
import MenuItem from "@material-ui/core/MenuItem";
import Menu from "@material-ui/core/Menu";
import { useHistory } from "react-router-dom";
import useMediaQuery from "@material-ui/core/useMediaQuery";

const useStyles = makeStyles((theme) => ({
  login: {
    float: "right",
    marginRight: theme.spacing(8),
    display: "flex",
    position: "absolute",
    right: "0px",
    color: "white",
    [theme.breakpoints.down("xs")]: {
      marginRight: theme.spacing(2),
    },
  },
  cm: {
    float: "right",
    marginRight: theme.spacing(20),
    display: "flex",
    position: "absolute",
    right: "0px",
    color: "white",
  },
  iconlogin: {
    float: "right",
    display: "flex",
    position: "absolute",
    right: "0px",
    color: "white",
    width: "100%",
    top: "25%",
  },
  text: {
    color: "white",
  },
  a8: {
    width: "100%",
  },
}));

// Configure FirebaseUI.
const uiConfig = {
  // Popup signin flow rather than redirect flow.
  signInFlow: "popup",
  // Redirect to /signedIn after sign in is successful. Alternatively you can provide a callbacks.signInSuccess function.
  signInSuccessUrl: "/",
  // We will display Google and Facebook as auth providers.
  signInOptions: [firebase.auth.GoogleAuthProvider.PROVIDER_ID, firebase.auth.TwitterAuthProvider.PROVIDER_ID, firebase.auth.FacebookAuthProvider.PROVIDER_ID],
};

export default function Header(props) {
  const classes = useStyles();
  const [open, setOpen] = React.useState(false);
  const [anchorEl, setAnchorEl] = React.useState(null);
  const openL = Boolean(anchorEl);
  const history = useHistory();
  const theme = useTheme();
  const matches = useMediaQuery(theme.breakpoints.up("sm"));
  // if (props.Pleaselogin){
  //   setOpen(true);
  // }
  const handleClickOpen = () => {
    setOpen(true);
  };

  const handleClose = () => {
    setOpen(false);
  };
  const handleCloseL = () => {
    setAnchorEl(null);
  };
  const handleMenu = (event) => {
    setAnchorEl(event.currentTarget);
  };
  // const toSchedule = () => {
  //   setAnchorEl(null);
  //   history.push({
  //     pathname: "/schedule",
  //   });
  // };

  const toSetting = () => {
    setAnchorEl(null);
    firebase.auth().onAuthStateChanged((user) => {
      firebase
        .auth()
        .signOut()
        .then(() => {
          history.push({
            pathname: "/",
          });
          window.location.reload();
        })
        .catch((error) => {
          console.log(`ログアウト時にエラーが発生しました (${error})`);
        });
    });
    history.push({
      pathname: "/setting",
    });
  };

  const toTop = () => {
    setAnchorEl(null);
    history.push({
      pathname: "/search",
    });
  };

  return (
    <div>
      <AppBar position="static">
        <Toolbar>
          <Link
            component="button"
            onClick={toTop}
            color="inherit"
            underline="none"
          >
            <Typography
              variant="h5"
              className={classes.text}
              component="h1"
              display="inline"
            >
              {matches ? "関西学院大学 非公式シラバス" : "非公式シラバス"}
            </Typography>
          </Link>

          {props.user ? (
            <IconButton
              aria-label="account of current user"
              aria-controls="menu-appbar"
              aria-haspopup="true"
              onClick={handleMenu}
              className={classes.login}
              color="inherit"
            >
              <AccountCircle />
            </IconButton>
          ) : (
            <Link
              component="button"
              align="right"
              className={classes.iconlogin}
              color="primary"
              onClick={handleClickOpen}
              size="large"
            >
              <Typography
                className={classes.login}
                variant="h6"
                component="h2"
                align="right"
                display="inline"
              >
                ログイン
              </Typography>
            </Link>
          )}
          <Menu
            id="menu-appbar"
            anchorEl={anchorEl}
            anchorOrigin={{
              vertical: "top",
              horizontal: "right",
            }}
            keepMounted
            transformOrigin={{
              vertical: "top",
              horizontal: "right",
            }}
            open={openL}
            onClose={handleCloseL}
          >
            {/* <MenuItem onClick={toSchedule}>時間割</MenuItem> */}
            <MenuItem onClick={toSetting}>ログアウト</MenuItem>
          </Menu>
          <Dialog
            open={open}
            onClose={handleClose}
            aria-labelledby="alert-dialog-title"
            aria-describedby="alert-dialog-description"
          >
            <DialogTitle id="alert-dialog-title">{"ログイン"}</DialogTitle>

            <DialogContent>
              <a href="/privacy">プライバシーポリシー&利用規約</a>
              <DialogContentText id="alert-dialog-description">
                {
                  "ログインしていただくと、当シラバスで教科検索時に、教科にレビューを書くことができます。"
                }
                <StyledFirebaseAuth
                  uiConfig={uiConfig}
                  firebaseAuth={firebase.auth()}
                />
              </DialogContentText>
            </DialogContent>
          </Dialog>
        </Toolbar>
      </AppBar>
    </div>
  );
}
