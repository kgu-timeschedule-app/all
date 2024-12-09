import {createTheme} from "@material-ui/core/styles";

export const theme = createTheme({
    palette: {
        primary: {
            main: "#5392F9",
        },
        secondary: {
            main: "#707070",
        },
        text: {
            icon: "#777777",
            title: "#3D5170",
        },
        common: {
            white: "#E9ECEF",
        },
        error: {
            main: "#e91e63",
        },
    },
    typography: {
        fontFamily: "futura-pt,Noto Sans CJK JP, Arial,Helvetica,sans-serif",
        color: "#4f4f4f",
        h1: {
            color: "#4f4f4f",
            fontSize: 50,
            fontWeight: 700,
            padding: "2rem 0",
        },
        h2: {
            color: "#4f4f4f",
            fontSize: 25,
            fontWeight: 900,
        },
        h3: {
            color: "#4f4f4f",
            fontSize: 40,
        },
        h4: {
            color: "#4f4f4f",
        },
        h5: {
            color: "#4f4f4f",
        },
        h6: {
            color: "#707070",
        },
        // 大きいサブタイトル
        subtitle1: {
            color: "#5392F9",
            fontSize: "1.5rem",
            fontWeight: 400,
            lineHeight: 1.334,
        },
        // 小さいサブタイトル
        subtitle2: {
            color: "#f4364c",
            fontSize: 19,
            fontWeight: "bold",
        },
        // 本文
        body1: {
            color: "#4f4f4f",
            fontSize: 16,
            lineHeight: 2,
        },
        // 細かい本文
        body2: {
            color: "#4f4f4f",
            fontSize: 16,
            lineHeight: 1.75,
        },
    },
});

export default theme;