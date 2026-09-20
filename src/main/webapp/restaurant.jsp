<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page isELIgnored="true" %>
    <%@ page import = "java.util.List" %>
    <%@ page import = "com.Food.Model.Restaurant"%>
    <%@ page import="com.Food.Model.User"%>
<%@ page import="com.Food.DAO.UserDAO"%>
<%@ page import="com.Food.daoimp.UserDAOImpl"%>
    
    <%
    List<Restaurant> allRestaurants =
        (List<Restaurant>) request.getAttribute("allRestaurants");
    
    
    String contextPath = request.getContextPath();
    
   
    String firstLetter = "U";

    Integer loggedInUserId =
        (Integer) session.getAttribute("userId");

    if (loggedInUserId != null) {
        UserDAO userDAO = new UserDAOImpl();
        User loggedInUser = userDAO.getUser(loggedInUserId);

        if (loggedInUser != null &&
            loggedInUser.getUserName() != null &&
            !loggedInUser.getUserName().trim().isEmpty()) {

            firstLetter = loggedInUser.getUserName()
                                      .trim()
                                      .substring(0, 1)
                                      .toUpperCase();
        }
    }

%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Zestora — Bengaluru's Food, Delivered</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,400;9..144,600;9..144,700;9..144,900&family=Work+Sans:wght@400;500;600;700&family=Space+Mono:wght@400;700&display=swap" rel="stylesheet">
<style>
  :root{
    --ink:#1F1811;
    --ink-soft:#3A2E22;
    --cream:#FBF3E3;
    --paper:#FFFCF6;
    --turmeric:#F4A900;
    --turmeric-deep:#D98E00;
    --chili:#C1272D;
    --chili-deep:#9E1E23;
    --leaf:#4F6F52;
    --line: rgba(31,24,17,0.12);
    --shadow: 0 10px 30px rgba(31,24,17,0.10);
    --radius: 18px;
  }
  *{box-sizing:border-box;}
  html{scroll-behavior:smooth;}
  body{
    margin:0;
    background:#FFFFFF;
    color:var(--ink);
    font-family:'Work Sans', sans-serif;
    -webkit-font-smoothing:antialiased;
  }
  h1,h2,h3{font-family:'Fraunces', serif; margin:0;}
  .mono{font-family:'Space Mono', monospace;}
  a{color:inherit; text-decoration:none;}
  img{max-width:100%; display:block;}
  .wrap{max-width:1180px; margin:0 auto; padding:0 24px;}

  /* ---------- Ticker ---------- */
  .ticker-bar{
    background:var(--ink);
    color:var(--cream);
    overflow:hidden;
    white-space:nowrap;
    padding:9px 0;
    font-family:'Space Mono', monospace;
    font-size:12.5px;
    letter-spacing:.04em;
  }
  .ticker-track{
    display:inline-block;
    padding-left:100%;
    animation:scroll-left 26s linear infinite;
  }
  .ticker-track span{ color:var(--turmeric); padding:0 10px;}
  @keyframes scroll-left{
    0%{transform:translateX(0);}
    100%{transform:translateX(-100%);}
  }

  /* ---------- Header ---------- */
  header{
    background:var(--paper);
    border-bottom:1px solid var(--line);
    position:sticky;
    top:0;
    z-index:50;
  }
  .header-inner{
    display:flex;
    align-items:center;
    gap:22px;
    padding:16px 24px;
    flex-wrap:wrap;
  }
.logo {
    font-size: 26px;
    font-weight: 700;
    display: flex;
    align-items: center;
    gap: 0;
    white-space: nowrap;
}


.logo-black {
    color: #111111;
}

.logo-red {
    color: #E53935;
}
  .logo .dot{color:var(--chili);}
 
  .locate{
    display:flex;
    align-items:center;
    gap:8px;
    font-size:13.5px;
    color:var(--ink-soft);
    border-left:1px solid var(--line);
    padding-left:18px;
    cursor:pointer;
  }
  .locate strong{display:block; font-size:14px; color:var(--ink);}
 

  .search-shell{
    flex:1 1 320px;
    display:flex;
    align-items:center;
    gap:10px;
    background:var(--cream);
    border:1px solid var(--line);
    border-radius:999px;
    padding:11px 18px;
    min-width:220px;
  }
  .search-shell input{
    border:none;
    background:transparent;
    outline:none;
    width:100%;
    font-family:'Work Sans',sans-serif;
    font-size:14.5px;
    color:var(--ink);
  }
  .search-shell input::placeholder{color:#8a7c6b;}

  .header-actions{display:flex; align-items:center; gap:12px;}
  .auth-btn{
    display:inline-flex; align-items:center; justify-content:center;
    padding:9px 16px; border-radius:999px;
    font-size:13px; font-weight:700;
    text-decoration:none; white-space:nowrap;
    transition:.15s;
  }
  .login-btn{
    background:var(--paper); color:var(--ink);
    border:1.5px solid var(--line);
  }
  .login-btn:hover{background:var(--cream); transform:translateY(-1px);}
  .signup-btn{
    background:var(--chili); color:#fff;
    border:1.5px solid var(--chili);
  }
  .signup-btn:hover{background:var(--chili-deep); transform:translateY(-1px);}

  .toggle-group{
    display:flex;
    border:1.5px solid var(--line);
    border-radius:999px;
    overflow:hidden;
    font-size:13px;
    font-weight:600;
  }
  .toggle-group button{
    border:none;
    background:var(--paper);
    padding:9px 16px;
    cursor:pointer;
    display:flex;
    align-items:center;
    gap:6px;
    color:var(--ink-soft);
    transition:.15s;
  }
  .toggle-group button.active.veg{background:var(--leaf); color:#fff;}
  .toggle-group button.active.nonveg{background:var(--chili); color:#fff;}
  .icon-btn{
    width:42px;height:42px;border-radius:50%;
    border:1.5px solid var(--line);
    background:var(--paper);
    display:flex;align-items:center;justify-content:center;
    cursor:pointer; position:relative;
  }
  #cartCount{
    position:absolute; top:-6px; right:-6px;
    background:var(--chili); color:#fff;
    font-size:10.5px; font-weight:700;
    width:18px;height:18px;border-radius:50%;
    display:flex;align-items:center;justify-content:center;
    font-family:'Space Mono',monospace;
  }

  /* ---------- Hero ---------- */
  .hero{
    background:var(--cream);
    color:var(--ink);
    position:relative;
    overflow:hidden;
    padding:70px 0 100px;
  }
  .hero::before{
    content:"";
    position:absolute; inset:0;
    background-image: radial-gradient(circle at 15% 20%, rgba(244,169,0,0.16), transparent 40%),
                       radial-gradient(circle at 85% 75%, rgba(193,39,45,0.20), transparent 45%);
    pointer-events:none;
  }
  .hero-grid{
    position:relative;
    display:grid;
    grid-template-columns:1.1fr 0.9fr;
    gap:50px;
    align-items:center;
  }
  .eyebrow{
    font-family:'Space Mono',monospace;
    font-size:12px;
    letter-spacing:.14em;
    text-transform:uppercase;
    color:var(--turmeric);
    display:flex; align-items:center; gap:10px;
    margin-bottom:18px;
  }
  .eyebrow::before{content:"";width:26px;height:1px;background:var(--turmeric);}
  .hero h1{
    font-size:clamp(38px,5vw,62px);
    line-height:1.04;
    font-weight:700;
    letter-spacing:-0.01em;
  }
  .hero h1 em{
    font-style:normal;
    color:var(--turmeric);
    position:relative;
  }
  .hero p.lede{
    font-size:17px;
    color:rgba(58,46,34,0.75);
    max-width:460px;
    margin:22px 0 32px;
    line-height:1.6;
  }
  .btn-chili{
    background:var(--chili);
    color:#fff;
    border:none;
    border-radius:999px;
    padding:12px 26px;
    font-weight:600;
    font-size:14.5px;
    cursor:pointer;
    transition:.15s;
    white-space:nowrap;
  }
  .btn-chili:hover{background:var(--chili-deep); transform:translateY(-1px);}
  .hero-stats{display:flex; gap:34px; margin-top:8px;}
  .hero-stats div strong{font-family:'Fraunces',serif; font-size:26px; display:block; color:var(--turmeric);}
  .hero-stats div span{font-size:12.5px; color:rgba(58,46,34,0.65);}

  /* signature: order-ticket stack */
  .ticket-stack{position:relative; height:400px;}
  .ticket{
    position:absolute;
    width:270px;
    background:var(--paper);
    color:var(--ink);
    border-radius:6px;
    padding:20px 20px 16px;
    box-shadow:0 18px 40px rgba(0,0,0,0.35);
    font-family:'Space Mono',monospace;
  }
  .ticket::before, .ticket::after{
    content:"";
    position:absolute;
    left:0; right:0; height:12px;
    background:
      radial-gradient(circle, transparent 6px, var(--paper) 6.5px) repeat-x;
    background-size:16px 16px;
  }
  .ticket::before{top:-6px;}
  .ticket::after{bottom:-6px; transform:rotate(180deg);}
  .ticket .t-head{display:flex; justify-content:space-between; font-size:11px; color:#9a8c78; border-bottom:1px dashed var(--line); padding-bottom:8px; margin-bottom:10px;}
  .ticket .t-name{font-family:'Fraunces',serif; font-size:19px; font-weight:600; margin-bottom:4px;}
  .ticket .t-sub{font-size:11px; color:#8a7c6b; margin-bottom:10px;}
  .ticket .t-price{display:flex; justify-content:space-between; align-items:center; font-size:13px;}
  .ticket .t-price b{font-size:17px;}
  .ticket-1{top:0; left:20px; transform:rotate(-7deg); z-index:2;}
  .ticket-2{top:70px; left:130px; transform:rotate(5deg); z-index:3; border:2px solid var(--turmeric);}
  .ticket-3{top:200px; left:10px; transform:rotate(3deg); z-index:1; opacity:.9;}
  .pin{
    position:absolute; width:14px;height:14px;border-radius:50%;
    background:var(--chili); box-shadow:0 3px 6px rgba(0,0,0,0.3);
    top:-7px; left:50%; transform:translateX(-50%); z-index:4;
  }

  /* ---------- Sections ---------- */
  section{padding:56px 0;}
  .section-head{
    display:flex; justify-content:space-between; align-items:flex-end;
    margin-bottom:28px; gap:20px; flex-wrap:wrap;
  }
  .section-head h2{font-size:clamp(24px,3vw,32px);}
  .section-head .kicker{
    font-family:'Space Mono',monospace; font-size:11.5px; letter-spacing:.12em;
    text-transform:uppercase; color:var(--chili); margin-bottom:8px; display:block;
  }
  .view-all{font-size:13.5px; font-weight:600; color:var(--chili); display:flex; align-items:center; gap:5px;}

  /* categories - thali ring */
  .craving{
    display:flex; gap:22px; overflow-x:auto; padding:6px 4px 18px;
    scrollbar-width:none;
  }
  .craving::-webkit-scrollbar{display:none;}
  .cat{
    flex:none; width:84px; text-align:center; cursor:pointer;
  }
  .cat .ring{
    width:74px; height:74px; border-radius:50%;
    display:flex; align-items:center; justify-content:center;
    font-size:30px;
    background:var(--paper);
    border:2px solid var(--line);
    margin:0 auto 10px;
    transition:.18s;
  }
  .cat.active .ring, .cat:hover .ring{
    border-color:var(--turmeric);
    background:#FFF3D6;
    transform:translateY(-4px);
  }
  .cat span{font-size:12.5px; font-weight:600; color:var(--ink-soft);}
  .cat.active span{color:var(--chili);}

  /* filter chips */
  .filters {
    display: flex;
    align-items: center;
    gap: 12px;
    width: 100%;
    margin: 20px 0 35px 0;
    padding: 0;
    flex-wrap: nowrap;
    margin-top: 0px !important;
    padding-top: 0px;
    padding-bottom: 0px;
   
}

.filters button {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    height: 38px;
    padding: 0 20px;

    border: 1px solid var(--line);
    border-radius: 999px;
    background: var(--paper);
    color: var(--ink);

    font-family: 'DM Sans', sans-serif;
    font-size: 14px;
    font-weight: 600;

    cursor: pointer;
    white-space: nowrap;

    transition: all 0.2s ease;
}

/*.filters button:hover {
    border-color: var(--ink);
    transform: translateY(-1px);
}*/

.filters button.active {
    background: var(--ink);
    color: #fff;
    border-color: var(--ink);
}

  /* restaurant cards */
  .rail{display:flex; gap:22px; overflow-x:auto; padding-bottom:10px; scroll-snap-type:x mandatory;}
  .grid{display:grid; grid-template-columns:repeat(auto-fill,minmax(250px,1fr)); gap:22px;}
  .rail::-webkit-scrollbar{height:6px;}
  .rail::-webkit-scrollbar-thumb{background:var(--line); border-radius:3px;}

  .card{
    background:var(--paper);
    border-radius:var(--radius);
    overflow:hidden;
    border:1px solid var(--line);
    box-shadow:var(--shadow);
    flex:none;
    width:250px;
    scroll-snap-align:start;
    transition:.18s;
    cursor:pointer;
    display:flex; flex-direction:column;
  }
  .grid .card{width:auto;}
  .card:hover{transform:translateY(-5px); box-shadow:0 16px 34px rgba(31,24,17,0.16);}
  .card-photo{
    height:130px;
    display:flex; align-items:center; justify-content:center;
    position:relative;
    overflow:hidden;
  }
  .card-photo img{
    position:absolute; inset:0;
    width:100%; height:100%;
    object-fit:cover;
  }
  .card-photo .photo-fallback{
    position:absolute; inset:0;
    display:flex; align-items:center; justify-content:center;
    font-family:'Fraunces',serif; font-size:36px; font-weight:700;
    color:var(--ink-soft);
  }
  .card-photo .veg-dot{
    position:absolute; top:10px; left:10px;
    width:20px; height:20px; border:2px solid #fff; border-radius:4px;
    display:flex; align-items:center; justify-content:center;
    background:rgba(255,255,255,0.9);
    z-index:2;
  }
  .card-photo .veg-dot i{width:9px;height:9px;border-radius:50%;}
  .veg-dot.veg i{background:var(--leaf);}
  .veg-dot.nonveg i{background:var(--chili);}
  .card-photo .offer-tag{
    position:absolute; top:10px; right:10px;
    background:var(--turmeric); color:var(--ink);
    font-size:10.5px; font-weight:700; padding:4px 9px; border-radius:999px;
    font-family:'Space Mono',monospace;
    z-index:2;
  }
  .card-body{padding:15px 16px 17px; flex:1; display:flex; flex-direction:column; gap:6px;}
  .card-body h3{font-size:16.5px; font-weight:600;}
  .card-cuisine{font-size:12px; color:#8a7c6b;}
  .card-meta{display:flex; justify-content:space-between; align-items:center; margin-top:6px; font-size:12.5px; color:var(--ink-soft);}
  .rating{
    display:flex; align-items:center; gap:4px; background:var(--leaf); color:#fff;
    font-weight:700; font-size:11.5px; padding:2px 7px; border-radius:6px;
  }
  .card-footer{
    display:flex; justify-content:space-between; align-items:center;
    margin-top:10px; padding-top:10px; border-top:1px dashed var(--line);
  }
  .price-mono{font-family:'Space Mono',monospace; font-size:13px; color:var(--ink-soft);}
  .add-btn{
    border:1.5px solid var(--chili); color:var(--chili); background:var(--paper);
    border-radius:999px; padding:5px 14px; font-size:12px; font-weight:700; cursor:pointer;
  }
  .add-btn:hover{background:var(--chili); color:#fff;}
  .stepper{
    display:flex; align-items:center; gap:0;
    border:1.5px solid var(--chili); border-radius:999px; overflow:hidden; background:var(--chili);
  }
  .stepper button{
    border:none; background:var(--chili); color:#fff; width:26px; height:26px;
    font-size:14px; font-weight:700; cursor:pointer; display:flex; align-items:center; justify-content:center;
  }
  .stepper span{
    background:var(--paper); color:var(--chili); font-family:'Space Mono',monospace; font-size:12.5px; font-weight:700;
    min-width:22px; text-align:center; padding:3px 0;
  }

  /* promo strip */
  .promo{
    background:linear-gradient(120deg, var(--chili), var(--chili-deep));
    color:#fff; border-radius:24px; padding:44px 40px;
    display:flex; justify-content:space-between; align-items:center; gap:24px; flex-wrap:wrap;
    position:relative; overflow:hidden;
  }
  .promo::after{
    content:"%"; position:absolute; right:-10px; bottom:-40px;
    font-family:'Fraunces',serif; font-size:220px; font-weight:900; color:rgba(255,255,255,0.08);
    line-height:1;
  }
  .promo h2{font-size:clamp(24px,3vw,34px); max-width:420px; position:relative;}
  .promo .btn-chili{background:var(--ink);}
  .promo .btn-chili:hover{background:#000;}

  /* footer */
  footer{background:var(--ink); color:rgba(251,243,227,0.7); padding:56px 0 26px; margin-top:40px;}
  .foot-grid{display:grid; grid-template-columns:1.4fr 1fr 1fr 1fr; gap:40px; padding-bottom:36px; border-bottom:1px solid rgba(251,243,227,0.12);}
  footer h3{color:var(--cream); font-family:'Fraunces',serif; font-size:22px; margin-bottom:10px;}
  footer p{font-size:13.5px; line-height:1.7;}
  footer h4{font-size:13px; text-transform:uppercase; letter-spacing:.08em; color:var(--turmeric); margin-bottom:14px;}
  footer ul{list-style:none; padding:0; margin:0; display:flex; flex-direction:column; gap:10px; font-size:13.5px;}
  .foot-bottom{display:flex; justify-content:space-between; padding-top:22px; font-size:12px; flex-wrap:wrap; gap:10px;}

  /* mobile bottom nav */
  .bottom-nav{
    display:none;
    position:fixed; bottom:16px; left:50%; transform:translateX(-50%);
    background:var(--ink); color:var(--cream);
    border-radius:999px; padding:8px; gap:6px;
    box-shadow:0 12px 30px rgba(0,0,0,0.3);
    z-index:60;
  }
  .bottom-nav button{
    border:none; background:transparent; color:inherit; font-family:'Work Sans',sans-serif;
    font-size:13px; font-weight:600; padding:10px 20px; border-radius:999px; display:flex; align-items:center; gap:6px; cursor:pointer;
  }
  .bottom-nav button.active{background:var(--turmeric); color:var(--ink);}

  /* ---------- Responsive ---------- */
  @media (max-width:920px){
    .hero-grid{grid-template-columns:1fr;}
    .ticket-stack{height:300px; margin-top:10px;}
    .foot-grid{grid-template-columns:1fr 1fr;}
  }
  @media (max-width:640px){
    .header-inner{padding:12px 16px;}
    .locate{display:none;}
    .toggle-group span.label{display:none;}
    .auth-btn{padding:8px 11px; font-size:12px;}
    .header-actions{gap:7px;}
    .hero{padding:44px 0 90px;}
    .btn-chili{padding:12px 18px; font-size:13px;}
    .promo{padding:32px 24px; text-align:center; justify-content:center;}
    section{padding:38px 0;}
    .foot-grid{grid-template-columns:1fr;}
    body{padding-bottom:78px;}
    .bottom-nav{display:flex;}
    .ticket-stack{display:none;}
  }
  
  /* ================= WHAT ARE YOU CRAVING ================= */

.craving-section {
    width: 100%;
     padding-top: 10px !important;
    padding-bottom: 0px !important;
    margin-top: 0px !important;
    max-width: 1200px;
    margin: 0 auto;
    padding: 45px 0 25px;
}

.craving-heading {
    margin-bottom: 28px;
}

.craving-kicker {
    display: block;
    color: #d52b2b;
    font-size: 11px;
    letter-spacing: 4px;
    font-weight: 500;
    margin-bottom: 10px;
     margin-left: 25px;
}

.craving-heading h2 {
    margin: 0;
    font-family: Georgia, "Times New Roman", serif;
    font-size: 30px;
    font-weight: 700;
    color: #17130f;
    margin-left: 25px;
}

/* Category row */

.category-container {
    display: flex;
    align-items: flex-start;
    justify-content: space-between;
    gap: 22px;
    width: 100%;
    overflow-x: auto;
    padding: 4px 5px 12px;
    scrollbar-width: none;
    margin-left: 30px;
    
}

.category-container::-webkit-scrollbar {
    display: none;
}

.category-item {
    flex: 0 0 auto;
    width: 92px;
    text-align: center;
    cursor: pointer;
}

/* Circle */

.category-icon {
    width: 78px;
    height: 78px;

    margin: 0 auto 12px;

    border-radius: 50%;

    display: flex;
    align-items: center;
    justify-content: center;

    background: #fffdf9;

    border: 2px solid #e5dfd6;

    font-size: 38px;

    transition: all 0.25s ease;
}

/* Text */

.category-item span {
    display: block;

    font-size: 14px;
    font-weight: 600;

    color: #17130f;

    white-space: nowrap;
}

/* Hover */

.category-item:hover .category-icon {
    transform: translateY(-3px);
    border-color: #f0a500;
}

/* Active category */

.category-item.active .category-icon {
    border: 2px solid #f0a500;
    background: #fff8e7;
    box-shadow: 0 3px 10px rgba(240, 165, 0, 0.12);
}

.category-item.active span {
    color: #d52b2b;
}
.card-location {
    font-size: 12.5px;
    color: #6f6254;
    display: flex;
    align-items: center;
    gap: 4px;
    margin-top: 1px;
}
.profile-avatar {
    background: var(--chili);
    color: #fff;
    font-weight: 700;
    font-size: 16px;
    border: none;
}
.profile-avatar {
    background: var(--chili);
    color: #fff;
    font-weight: 700;
    font-size: 16px;
    border: none;
}
/* ================= CHATBOT ================= */

.chatbot-button {
    position: fixed;
    right: 25px;
    bottom: 25px;
    width: 58px;
    height: 58px;
    border-radius: 50%;
    border: none;
    background: var(--chili);
    color: #fff;
    font-size: 25px;
    cursor: pointer;
    box-shadow: 0 8px 25px rgba(0,0,0,0.22);
    z-index: 1000;
    transition: 0.2s ease;
}

.chatbot-button:hover {
    transform: scale(1.08);
    background: var(--chili-deep);
}

/* Chat window */

.chatbot-box {
    position: fixed;
    right: 25px;
    bottom: 95px;
    width: 350px;
    height: 480px;
    background: var(--paper);
    border-radius: 20px;
    box-shadow: 0 15px 45px rgba(0,0,0,0.25);
    border: 1px solid var(--line);
    overflow: hidden;
    display: none;
    flex-direction: column;
    z-index: 999;
}

.chatbot-box.open {
    display: flex;
}

/* Header */

.chatbot-header {
    background: var(--chili);
    color: white;
    padding: 16px 18px;
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.chatbot-header-left {
    display: flex;
    align-items: center;
    gap: 10px;
}

.chatbot-icon {
    width: 38px;
    height: 38px;
    border-radius: 50%;
    background: white;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 21px;
}

.chatbot-title {
    font-family: 'Fraunces', serif;
    font-size: 18px;
    font-weight: 600;
}

.chatbot-status {
    font-size: 11px;
    opacity: 0.85;
}

.chatbot-close {
    background: transparent;
    border: none;
    color: white;
    font-size: 22px;
    cursor: pointer;
}

/* Messages */

.chatbot-messages {
    flex: 1;
    padding: 15px;
    overflow-y: auto;
    background: #fffaf2;
}

.chat-message {
    max-width: 82%;
    padding: 10px 13px;
    margin-bottom: 10px;
    border-radius: 14px;
    font-size: 13px;
    line-height: 1.45;
}

.bot-message {
    background: #f1e6d5;
    color: var(--ink);
    border-bottom-left-radius: 4px;
}

.user-message {
    background: var(--chili);
    color: white;
    margin-left: auto;
    border-bottom-right-radius: 4px;
}

/* Quick questions */

.chatbot-quick {
    padding: 8px 12px;
    display: flex;
    gap: 7px;
    overflow-x: auto;
    border-top: 1px solid var(--line);
    background: var(--paper);
}

.chatbot-quick button {
    flex: none;
    padding: 7px 11px;
    border: 1px solid var(--line);
    border-radius: 999px;
    background: white;
    font-size: 11px;
    cursor: pointer;
}

.chatbot-quick button:hover {
    border-color: var(--chili);
    color: var(--chili);
}

/* Input */

.chatbot-input {
    display: flex;
    gap: 8px;
    padding: 12px;
    border-top: 1px solid var(--line);
    background: var(--paper);
}

.chatbot-input input {
    flex: 1;
    border: 1px solid var(--line);
    border-radius: 999px;
    padding: 10px 14px;
    outline: none;
    font-family: 'Work Sans', sans-serif;
    font-size: 13px;
}

.chatbot-input input:focus {
    border-color: var(--chili);
}

.chatbot-send {
    width: 40px;
    height: 40px;
    border: none;
    border-radius: 50%;
    background: var(--chili);
    color: white;
    cursor: pointer;
    font-size: 17px;
}

.chatbot-send:hover {
    background: var(--chili-deep);
}

/* Mobile */

@media (max-width: 640px) {

    .chatbot-box {
        right: 12px;
        left: 12px;
        bottom: 85px;
        width: auto;
        height: 450px;
    }

    .chatbot-button {
        right: 18px;
        bottom: 85px;
    }
}
/* ===== RESTAURANT CARD ALIGNMENT FIX ===== */

.restaurant-card {
    min-width: 250px;
}

.rail {
    display: flex;
    gap: 22px;
    overflow-x: auto;
    align-items: stretch;
}

.rail .restaurant-card {
    flex: 0 0 250px;
}

.grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
    gap: 22px;
    align-items: stretch;
}

.grid .restaurant-card {
    min-width: 0;
    width: 100%;
}

.restaurant-card-link {
    display: flex;
    flex-direction: column;
    width: 100%;
    height: 100%;
    text-decoration: none;
    color: inherit;
}

.restaurant-card[style*="display: none"] {
    display: none !important;
}
/* =====================================================
   ZESTORA RESTAURANT PAGE - MOBILE RESPONSIVE
   ===================================================== */

@media (max-width: 640px) {

    html,
    body {
        width: 100%;
        max-width: 100%;
        overflow-x: hidden;
    }

    /* ---------- HEADER ---------- */

    .header-inner {
        width: 100%;
        padding: 10px 12px;
        gap: 8px;
        flex-wrap: nowrap;
    }

    .logo {
        font-size: 21px;
        flex-shrink: 0;
    }

 .search-shell {
    display: flex;
    width: 100%;
    max-width: 220px;
}

    .locate {
        display: none;
    }

    .header-actions {
        margin-left: auto;
        gap: 5px;
        flex-shrink: 0;
    }

    .auth-btn {
        padding: 7px 9px;
        font-size: 11px;
    }

    .toggle-group {
        display: none;
    }

    .icon-btn {
        width: 34px;
        height: 34px;
        font-size: 15px;
    }

    /* ---------- HERO ---------- */

    .hero {
        padding: 38px 0 55px;
    }

    .wrap {
        width: 100%;
        max-width: 100%;
        padding-left: 16px;
        padding-right: 16px;
    }

    .hero-grid {
        display: block;
    }

    .eyebrow {
        font-size: 9px;
        margin-bottom: 12px;
    }

    .hero h1 {
        font-size: 36px;
        line-height: 1.08;
    }

    .hero p.lede {
        font-size: 14px;
        line-height: 1.5;
        margin: 16px 0 22px;
    }

    .hero-stats {
        gap: 16px;
        flex-wrap: wrap;
    }

    .hero-stats div strong {
        font-size: 21px;
    }

    .hero-stats div span {
        font-size: 10px;
    }

    .ticket-stack {
        display: none;
    }

    /* ---------- CRAVING SECTION ---------- */

    .craving-section {
        width: 100%;
        padding: 30px 0 10px !important;
        margin: 0;
    }

    .craving-heading {
        margin-bottom: 20px;
        padding: 0 16px;
    }

    .craving-kicker {
        font-size: 9px;
        letter-spacing: 3px;
        margin-left: 0;
    }

    .craving-heading h2 {
        font-size: 25px;
        margin-left: 0;
        line-height: 1.2;
    }

    .category-container {
        width: 100%;
        margin-left: 0;
        padding: 4px 16px 12px;
        gap: 14px;
        justify-content: flex-start;
        overflow-x: auto;
    }

    .category-item {
        width: 75px;
        flex: 0 0 75px;
    }

    .category-icon {
        width: 64px;
        height: 64px;
        font-size: 30px;
        margin-bottom: 8px;
    }

    .category-item span {
        font-size: 11px;
    }

    /* ---------- FILTERS ---------- */

    .filters {
        width: 100%;
        overflow-x: auto;
        gap: 8px;
        margin: 12px 0 24px !important;
        padding: 0 16px;
        scrollbar-width: none;
    }

    .filters::-webkit-scrollbar {
        display: none;
    }

    .filters button {
        height: 34px;
        padding: 0 13px;
        font-size: 12px;
        flex-shrink: 0;
    }

    /* ---------- SECTION HEADINGS ---------- */

    .section-head {
        align-items: flex-start;
        margin-bottom: 18px;
        gap: 8px;
    }

    .section-head h2 {
        font-size: 24px;
        line-height: 1.2;
    }

    .section-head .kicker {
        font-size: 10px;
    }

    .view-all {
        font-size: 11px;
        white-space: nowrap;
    }

    /* ---------- RESTAURANT CARDS ---------- */

    .rail {
        gap: 14px;
        overflow-x: auto;
        padding-bottom: 8px;
        scrollbar-width: none;
    }

    .rail::-webkit-scrollbar {
        display: none;
    }

    .rail .restaurant-card {
        flex: 0 0 220px;
        min-width: 220px;
        width: 220px;
    }

    .grid {
        grid-template-columns: 1fr;
        gap: 16px;
    }

    .grid .restaurant-card {
        width: 100%;
        min-width: 0;
    }

    .card-photo {
        height: 125px;
    }

    .card-body {
        padding: 12px 13px 14px;
    }

    .card-body h3 {
        font-size: 15px;
    }

    .card-location {
        font-size: 11px;
    }

    .card-cuisine {
        font-size: 11px;
    }

    .card-meta {
        font-size: 11px;
    }

    /* ---------- PROMO ---------- */

    .promo {
        margin-left: 16px;
        margin-right: 16px;
        padding: 28px 20px;
        border-radius: 18px;
        text-align: center;
        justify-content: center;
    }

    .promo h2 {
        font-size: 25px;
    }

    /* ---------- FOOTER ---------- */

    footer {
        padding: 40px 16px 90px;
    }

    .foot-grid {
        grid-template-columns: 1fr;
        gap: 28px;
    }

    .foot-bottom {
        flex-direction: column;
        gap: 8px;
    }

    /* ---------- CHATBOT ---------- */

    .chatbot-button {
        width: 50px;
        height: 50px;
        right: 16px;
        bottom: 82px;
        font-size: 21px;
    }

    .chatbot-box {
        left: 10px;
        right: 10px;
        bottom: 80px;
        width: auto;
        height: 440px;
        border-radius: 16px;
    }

}
</style>
</head>
<body>


<!-- style end -->

  <div class="ticker-bar">
    <div class="ticker-track mono">
      🔥 TRENDING NOW <span>·</span> MASALA DOSA <span>·</span> HYDERABADI BIRYANI <span>·</span> COLD COFFEE <span>·</span> MOMOS <span>·</span> BUTTER CHICKEN <span>·</span> FILTER COFFEE <span>·</span> 20% OFF ON FIRST ORDER <span>·</span> FREE DELIVERY ABOVE ₹199 <span>·</span> MASALA DOSA <span>·</span> HYDERABADI BIRYANI <span>·</span> COLD COFFEE <span>·</span> MOMOS <span>·</span> BUTTER CHICKEN <span>·</span> FILTER COFFEE <span>·</span> 20% OFF ON FIRST ORDER <span>·</span>
    </div>
  </div>

  <header>
    <div class="header-inner">
    <div class="logo">
   

    <span class="logo-black">Zest</span><span class="logo-red">ora</span>
</div>
      <div class="locate" id="locateBox">
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#C1272D" stroke-width="2"><path d="M12 21s-7-6.2-7-11a7 7 0 0114 0c0 4.8-7 11-7 11z"/><circle cx="12" cy="10" r="2.5"/></svg>
        <div>
          <strong id="locCity">Bengaluru</strong>
          <span id="locArea">Koramangala, 4th Block</span>
        </div>
      </div>
      <div class="search-shell">
        <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="#8a7c6b" stroke-width="2"><circle cx="11" cy="11" r="7"/><path d="M21 21l-4.3-4.3"/></svg>
       <input
    type="text"
    id="searchInput"
    placeholder="Search for restaurants or dishes..."
    oninput="searchRestaurants()">
      </div>
   <div class="header-actions">

    <% if (loggedInUserId == null) { %>

        <a class="auth-btn login-btn" href="login.jsp">Login</a>
        <a class="auth-btn signup-btn" href="signup.jsp">Sign Up</a>

    <% } %>

    <div class="toggle-group">
          <button id="vegButton" class="veg" onclick="filterFoodType('Veg')">🌱 <span class="label">Veg</span></button>
          <button id="nonVegButton" class="nonveg" onclick="filterFoodType('Non-Veg')">🍗 <span class="label">Non-Veg</span></button>
        </div>
        <a class="icon-btn" id="cartBtn" href="cart" title="View cart">
          🛒<span id="cartCount">0</span>
        </a>
        
      

<div class="icon-btn profile-avatar"
     onclick="location.href='<%= contextPath %>/account'"
     title="Account">
    <%= firstLetter %>
</div>
      </div>
    </div>
  </header>

  <section class="hero">
    <div class="wrap hero-grid">
      <div>
        <span class="eyebrow"> Delivering since 8:00 AM</span>
        <h1>Your next craving is<br><em>one tap</em> away.</h1>
        <p class="lede">From filter coffee to five-star biryani — Zestora brings Bengaluru's best kitchens straight to your door, hot and on time.</p>
        <div class="hero-stats">
          <div><strong>1,200+</strong><span>Restaurants</span></div>
          <div><strong>28 min</strong><span>Avg. delivery</span></div>
          <div><strong>4.6★</strong><span>Avg. rating</span></div>
        </div>
      </div>
      <div class="ticket-stack">
        <div class="ticket ticket-3">
          <div class="t-head"><span>ORDER #204</span><span>08:41 PM</span></div>
          <div class="t-name">Cold Coffee</div>
          <div class="t-sub">Third Wave Coffee</div>
          <div class="t-price"><span>QTY 2</span><b>₹190</b></div>
        </div>
        <div class="ticket ticket-1">
          <div class="pin"></div>
          <div class="t-head"><span>ORDER #201</span><span>08:12 PM</span></div>
          <div class="t-name">Chicken Biryani</div>
          <div class="t-sub">Meghana Foods</div>
          <div class="t-price"><span>QTY 1</span><b>₹320</b></div>
        </div>
        <div class="ticket ticket-2">
          <div class="pin"></div>
          <div class="t-head"><span>ORDER #202</span><span>08:20 PM</span></div>
          <div class="t-name">Masala Dosa</div>
          <div class="t-sub">Sangeetha</div>
          <div class="t-price"><span>QTY 3</span><b>₹210</b></div>
        </div>
      </div>
    </div>
  </section>
     <!-- ================= WHAT ARE YOU CRAVING ================= -->
<section class="craving-section">

    <div class="craving-heading">
        <span class="craving-kicker">PICK A PLATE</span>
        <h2>What are you craving?</h2>
    </div>

    <div class="category-container">

        <div class="cat" onclick="filterRestaurants('All', this)">
            <div class="ring">🍽️</div>
            <span>All</span>
        </div>

        <div class="cat"
     onclick="filterRestaurants('Biryani', this)">
    <div class="ring">🍛</div>
    <span>Biryani</span>
</div>

<div class="cat"
     onclick="filterRestaurants('Dosa', this)">
    <div class="ring">🥞</div>
    <span>Dosa</span>
</div>

        <div class="cat"
     onclick="filterRestaurants('Pizza', this)">
    <div class="ring">🍕</div>
    <span>Pizza</span>
</div>

        <div class="cat"
     onclick="filterRestaurants('Burger', this)">
    <div class="ring">🍔</div>
    <span>Burger</span>
</div>

<div class="cat"
     onclick="filterRestaurants('Chinese', this)">
    <div class="ring">🥡</div>
    <span>Chinese</span>
</div>

        <div class="cat" onclick="filterRestaurants('Momos', this)">
            <div class="ring">🥟</div>
            <span>Momos</span>
        </div>

        <div class="cat" onclick="filterRestaurants('Pasta', this)">
            <div class="ring">🍝</div>
            <span>Pasta</span>
        </div>

        <div class="cat" onclick="filterRestaurants('Cakes', this)">
            <div class="ring">🍰</div>
            <span>Cakes</span>
        </div>

        <div class="cat" onclick="filterRestaurants('Rolls', this)">
            <div class="ring">🌯</div>
            <span>Rolls</span>
        </div>

        <div class="cat" onclick="filterRestaurants('Coffee', this)">
            <div class="ring">☕</div>
            <span>Coffee</span>
        </div>

    </div>

</section>
       
    <div class="craving" id="cravingRow">     
    </div>
   <section class="wrap">
    <div class="filters">

      <button type="button" data-filter="rating">
    ⭐ Rating 4.0+
</button>

        <button type="button"
                data-filter="offers">
            🏷️ Offers
        </button>

        <button type="button"
                data-filter="price">
            ₹ Price
        </button>

        <button type="button"
                data-filter="fast">
            ⚡ Fast Delivery
        </button>

        <button type="button"
                data-filter="sort">
            ↕️ Sort By
        </button>

    </div>


  </section>
  
  
  
  
  
<!-- ================= TOP PICKS ================= -->




<section class="wrap filter-section" id="toppicksSection">

    <div class="section-head">

        <div>
            <span class="kicker">Handpicked For You</span>
            <h2>🔥 Top Pick's</h2>
        </div>

        <span class="view-all">View all →</span>

    </div>

    <p style="color:#8a7c6b; margin-top:-16px; margin-bottom:24px;">
    
        
    </p>

<div class="rail" id="topPicksRail">

<%
    if (allRestaurants != null && !allRestaurants.isEmpty()) {

        // Find 10 highest-rated active restaurants
        boolean[] selected = new boolean[allRestaurants.size()];

        for (int count = 0; count < 10 && count < allRestaurants.size(); count++) {

            int highestIndex = -1;
            double highestRating = -1;

            for (int i = 0; i < allRestaurants.size(); i++) {

                Restaurant r = allRestaurants.get(i);

                if (!r.isActive() || selected[i]) {
                    continue;
                }

                if (r.getRating() > highestRating) {
                    highestRating = r.getRating();
                    highestIndex = i;
                }
            }

            if (highestIndex == -1) {
                break;
            }

            selected[highestIndex] = true;

            Restaurant restaurant = allRestaurants.get(highestIndex);
%>


<div class="card restaurant-card"
     data-cuisine="<%= restaurant.getCuisineType() %>"
     data-veg="<%= restaurant.Veg() %>">

<a href="<%= contextPath %>/menu?restaurantId=<%= restaurant.getRestaurantId() %>"
   class="restaurant-card-link">
   
        <div class="card-photo">

            <img src="<%= restaurant.getPhoto() %>"
                 alt="<%= restaurant.getName() %>"
                 loading="lazy">

            <div class="veg-dot <%= restaurant.Veg() ? "veg" : "nonveg" %>">
                <i></i>
            </div>

            <% if (restaurant.getOffer() != null &&
                   !restaurant.getOffer().trim().isEmpty()) { %>

                <div class="offer-tag">
                    <%= restaurant.getOffer() %>
                </div>

            <% } %>

        </div>
      

        <div class="card-body">

            <h3>
                <%= restaurant.getName() %>
            </h3>
            
              <div class="card-location">
                📍 <%= restaurant.getLocation() %>
            </div>

            <div class="card-cuisine">
                <%= restaurant.getCuisineType() %>
            </div>

            <div class="card-meta">

                <span class="rating">
                    ★ <%= restaurant.getRating() %>
                </span>

                <span>
                    ⏱ <%= restaurant.getDeliveryTime() %> mins
                </span>

            </div>

        </div>
        </a>

    </div>

<%
        }

    } else {
%>

    <p>No restaurants found.</p>

<%
    }
%>

</div>


</section>

<!---- end of top picks--->




  <section class="wrap filter-section" id="popularSection">

    <div class="section-head">

        <div>
            <span class="kicker">Waiting For You</span>
            <h2>📍 Popular Near You</h2>
        </div>

        <span class="view-all">View all →</span>

    </div>

    <p style="color:#8a7c6b; margin-top:-16px; margin-bottom:24px;">
    
        
    </p>
  


<div class="grid" id="popularGrid">

<%
    if (allRestaurants != null) {

        for (Restaurant restaurant : allRestaurants) {

            if (!restaurant.isActive()) {
                continue;
            }

            String cuisine = restaurant.getCuisineType();

            if (cuisine == null) {
                cuisine = "";
            }

            cuisine = cuisine.toLowerCase();

            /*
             * Do NOT show these in Popular Near You:
             * Cafes
             * Coffee
             * Desserts
             * Cakes
             * Sweets
             */

            if (cuisine.contains("cafe") ||
                cuisine.contains("coffee") ||
                cuisine.contains("dessert") ||
                cuisine.contains("cake") ||
                cuisine.contains("sweet")) {

                continue;
            }
%>


   <div class="card restaurant-card"
     data-cuisine="<%= restaurant.getCuisineType() %>"
     data-veg="<%= restaurant.Veg() %>">
     
     <a href="<%= contextPath %>/menu?restaurantId=<%= restaurant.getRestaurantId() %>"
       class="restaurant-card-link">

        <div class="card-photo">

            <img src="<%= restaurant.getPhoto() %>"
                 alt="<%= restaurant.getName() %>"
                 loading="lazy">
                 
                 

            <div class="veg-dot <%= restaurant.Veg() ? "veg" : "nonveg" %>">
                <i></i>
            </div>

            <% if (restaurant.getOffer() != null &&
                   !restaurant.getOffer().trim().isEmpty()) { %>

                <div class="offer-tag">
                    <%= restaurant.getOffer() %>
                </div>

            <% } %>

        </div>
       

        <div class="card-body">

            <h3>
                <%= restaurant.getName() %>
            </h3>
            
              <div class="card-location">
                📍 <%= restaurant.getLocation() %>
            </div>

            <div class="card-cuisine">
                <%= restaurant.getCuisineType() %>
            </div>

            <div class="card-meta">

                <span class="rating">
                    ★ <%= restaurant.getRating() %>
                </span>

                <span>
                    ⏱ <%= restaurant.getDeliveryTime() %> mins
                </span>

            </div>

        </div>
        
        </a>

    </div>

<%
        }
    }
%>

</div>


</section>

<!-- =========================================================
     CAFES & COFFEE
     ========================================================= -->

<section class="wrap filter-section" id="cafesSection">

    <div class="section-head">

        <div>
            <span class="kicker">Coffee &amp; chill</span>
            <h2>☕ Cafés &amp; Coffee</h2>
        </div>

        <span class="view-all">View all →</span>

    </div>

    <p style="color:#8a7c6b; margin-top:-16px; margin-bottom:24px;">
        Cozy cafés, cold brews and your perfect coffee break.
    </p>


    <div class="rail">

        <%
            if (allRestaurants != null) {

                for (Restaurant restaurant : allRestaurants) {

                    if (!restaurant.isActive()) {
                        continue;
                    }

                    String cuisine = restaurant.getCuisineType();

                    if (cuisine != null &&
                        cuisine.toLowerCase().contains("cafe")) {
        %>


        <!-- RESTAURANT CARD -->
        
     

     <div class="card restaurant-card"
     data-cuisine="<%= restaurant.getCuisineType() %>"
     data-veg="<%= restaurant.Veg() %>">
     
     <a href="<%= contextPath %>/menu?restaurantId=<%= restaurant.getRestaurantId() %>"
       class="restaurant-card-link">

            <div class="card-photo">

                <img src="<%= restaurant.getPhoto() %>"
                     alt="<%= restaurant.getName() %>"
                     loading="lazy">

                <div class="veg-dot <%= restaurant.Veg() ? "veg" : "nonveg" %>">
                    <i></i>
                </div>


                <%
                    if (restaurant.getOffer() != null &&
                        !restaurant.getOffer().trim().isEmpty()) {
                %>

                    <div class="offer-tag">
                        <%= restaurant.getOffer() %>
                    </div>

                <%
                    }
                %>

            </div>


            <div class="card-body">

                <h3>
                    <%= restaurant.getName() %>
                </h3>
                
                  <div class="card-location">
                📍 <%= restaurant.getLocation() %>
            </div>
            

                <div class="card-cuisine">
                    <%= restaurant.getCuisineType() %>
                </div>

                <div class="card-meta">

                    <span class="rating">
                        ★ <%= restaurant.getRating() %>
                    </span>

                    <span>
                        ⏱ <%= restaurant.getDeliveryTime() %> mins
                    </span>

                </div>

            </div>
            
            </a>

        </div>


        <%
                    }
                }
            }
        %>

    </div>
    
  

</section>



<!-- =========================================================
     DESSERTS & CAKES
     ========================================================= -->

<section class="wrap filter-section" id="dessertsSection">

    <div class="section-head">

        <div>
            <span class="kicker">Sweet cravings</span>
            <h2>🍰 Desserts &amp; Cakes</h2>
        </div>

        <span class="view-all">View all →</span>

    </div>

    <p style="color:#8a7c6b; margin-top:-16px; margin-bottom:24px;">
        Cakes, chocolate treats and desserts made for happy moments.
    </p>


    <div class="rail">

        <%
            if (allRestaurants != null) {

                for (Restaurant restaurant : allRestaurants) {

                    if (!restaurant.isActive()) {
                        continue;
                    }

                    String cuisine = restaurant.getCuisineType();

                    if (cuisine != null &&
                        (cuisine.toLowerCase().contains("dessert") ||
                         cuisine.toLowerCase().contains("cake"))) {
        %>


        <!-- RESTAURANT CARD -->



<div class="card restaurant-card"
     data-cuisine="<%= restaurant.getCuisineType() %>"
     data-veg="<%= restaurant.Veg() %>">
     
     <a href="<%= contextPath %>/menu?restaurantId=<%= restaurant.getRestaurantId() %>"
       class="restaurant-card-link">

            <div class="card-photo">

                <img src="<%= restaurant.getPhoto() %>"
                     alt="<%= restaurant.getName() %>"
                     loading="lazy">

                <div class="veg-dot <%= restaurant.Veg() ? "veg" : "nonveg" %>">
                    <i></i>
                </div>


                <%
                    if (restaurant.getOffer() != null &&
                        !restaurant.getOffer().trim().isEmpty()) {
                %>

                    <div class="offer-tag">
                        <%= restaurant.getOffer() %>
                    </div>

                <%
                    }
                %>

            </div>


            <div class="card-body">

                <h3>
                    <%= restaurant.getName() %>
                </h3>
                
                  <div class="card-location">
                📍 <%= restaurant.getLocation() %>
            </div>

                <div class="card-cuisine">
                    <%= restaurant.getCuisineType() %>
                </div>

                <div class="card-meta">

                    <span class="rating">
                        ★ <%= restaurant.getRating() %>
                    </span>

                    <span>
                        ⏱ <%= restaurant.getDeliveryTime() %> mins
                    </span>

                </div>

            </div>
            
            </a>

        </div>


        <%
                    }
                }
            }
        %>

    </div>
    </a>

</section>



<!-- =========================================================
     SWEETS & INDIAN TREATS
     ========================================================= -->

<section class="wrap filter-section" id="sweetsSection">

    <div class="section-head">

        <div>
            <span class="kicker">Traditional favourites</span>
            <h2>🍬 Sweets &amp; Indian Treats</h2>
        </div>

        <span class="view-all">View all →</span>

    </div>

    <p style="color:#8a7c6b; margin-top:-16px; margin-bottom:24px;">
        Classic Indian sweets and little bites worth celebrating.
    </p>


    <div class="rail">

        <%
            if (allRestaurants != null) {

                for (Restaurant restaurant : allRestaurants) {

                    if (!restaurant.isActive()) {
                        continue;
                    }

                    String cuisine = restaurant.getCuisineType();

                    if (cuisine != null &&
                        cuisine.toLowerCase().contains("sweet")) {
        %>


        <!-- RESTAURANT CARD -->
        
     

    <div class="card restaurant-card"
     data-cuisine="<%= restaurant.getCuisineType() %>"
     data-veg="<%= restaurant.Veg() %>">
     
       <a href="<%= contextPath %>/menu?restaurantId=<%= restaurant.getRestaurantId() %>"
       class="restaurant-card-link">
     
     

            <div class="card-photo">

                <img src="<%= restaurant.getPhoto() %>"
                     alt="<%= restaurant.getName() %>"
                     loading="lazy">

                <div class="veg-dot <%= restaurant.Veg() ? "veg" : "nonveg" %>">
                    <i></i>
                </div>


                <%
                    if (restaurant.getOffer() != null &&
                        !restaurant.getOffer().trim().isEmpty()) {
                %>

                    <div class="offer-tag">
                        <%= restaurant.getOffer() %>
                    </div>

                <%
                    }
                %>

            </div>


            <div class="card-body">

                <h3>
                    <%= restaurant.getName() %>
                </h3>
                
                <div class="card-location">
        📍 <%= restaurant.getLocation() %>
    </div>

                <div class="card-cuisine">
                    <%= restaurant.getCuisineType() %>
                </div>

                <div class="card-meta">

                    <span class="rating">
                        ★ <%= restaurant.getRating() %>
                    </span>

                    <span>
                        ⏱ <%= restaurant.getDeliveryTime() %> mins
                    </span>

                </div>

            </div>
            
            </a>

        </div>


        <%
                    }
                }
            }
        %>

    </div>
    
   

</section>


<!-- ================= ZESTORA CHATBOT ================= -->

<button class="chatbot-button"
        id="chatbotButton"
        onclick="toggleChatbot()">
    💬
</button>

<div class="chatbot-box" id="chatbotBox">

    <div class="chatbot-header">

        <div class="chatbot-header-left">

            <div class="chatbot-icon">
                🤖
            </div>

            <div>
                <div class="chatbot-title">
                    Zestora AI
                </div>

                <div class="chatbot-status">
                    ● Online · How can I help?
                </div>
            </div>

        </div>

        <button class="chatbot-close"
                onclick="toggleChatbot()">
            ×
        </button>

    </div>

    <div class="chatbot-messages"
         id="chatbotMessages">

        <div class="chat-message bot-message">
            👋 Hi! I'm Zestora AI.<br>
            How can I help you today?
        </div>

    </div>

    <div class="chatbot-quick">

        <button onclick="sendQuickMessage('Show me vegetarian food')">
            🌱 Veg Food
        </button>

        <button onclick="sendQuickMessage('How do I order food?')">
            🍔 How to Order
        </button>

        <button onclick="sendQuickMessage('How do I add food to cart?')">
            🛒 Cart Help
        </button>

    </div>

    <div class="chatbot-input">

        <input type="text"
               id="chatbotInput"
               placeholder="Ask Zestora..."
               onkeydown="handleChatKey(event)">

        <button class="chatbot-send"
                onclick="sendChatMessage()">
            ➤
        </button>

    </div>

</div>


</body>







<script>

/* ================= ZESTORA CHATBOT ================= */

function toggleChatbot() {

    const chatbot = document.getElementById("chatbotBox");

    chatbot.classList.toggle("open");

}


/* Send quick question */

function sendQuickMessage(message) {

    document.getElementById("chatbotInput").value = message;

    sendChatMessage();

}


/* Enter key */

function handleChatKey(event) {

    if (event.key === "Enter") {
        sendChatMessage();
    }

}


/* Send message */

function sendChatMessage() {

    const input = document.getElementById("chatbotInput");
    const message = input.value.trim();

    if (message === "") {
        return;
    }

    addChatMessage(message, "user-message");

    input.value = "";

    setTimeout(function() {

        const reply = getBotReply(message);

        addChatMessage(reply, "bot-message");

    }, 500);

}


/* Add message */

function addChatMessage(message, type) {

    const messages =
        document.getElementById("chatbotMessages");

    const div = document.createElement("div");

    div.className = "chat-message " + type;

    div.innerHTML = message;

    messages.appendChild(div);

    messages.scrollTop = messages.scrollHeight;

}


/* Basic chatbot responses */

function getBotReply(message) {

    const text = message.toLowerCase();


    if (text.includes("veg") ||
        text.includes("vegetarian")) {

        return "🌱 You can use the <b>Veg</b> filter at the top of the page to find vegetarian restaurants and food.";
    }


    if (text.includes("cart") ||
        text.includes("add")) {

        return "🛒 Choose a restaurant, open its menu, and click <b>ADD</b> on the food item you want.";
    }


    if (text.includes("order") ||
        text.includes("how to order")) {

        return "🍔 Choose a restaurant → select your food → add it to the cart → checkout → choose your payment method → place your order.";
    }


    if (text.includes("payment") ||
        text.includes("pay")) {

        return "💳 Zestora supports the payment methods available on the checkout page.";
    }


    if (text.includes("favorite") ||
        text.includes("favourite")) {

        return "❤️ Tap the heart button on a food item to save it to your Favorites.";
    }


    if (text.includes("restaurant")) {

        return "🍽️ You can browse the restaurants shown on this page and select one to view its menu.";
    }


    if (text.includes("hello") ||
        text.includes("hi") ||
        text.includes("hey")) {

        return "👋 Hello! Welcome to Zestora. What would you like to eat today?";
    }


    if (text.includes("help")) {

        return "😊 I can help you with restaurants, food, cart, orders, favorites and payments.";
    }


    return "😊 I'm here to help! Try asking me about <b>restaurants, food, cart, orders, favorites</b> or <b>payments</b>.";
}
let selectedCategory = "All";
let selectedFoodType = "All";
let searchText = "";



/* =========================================
   CUISINE ICON FILTER
   ========================================= */

function filterRestaurants(category, element) {
	

    document.querySelectorAll('.cat').forEach(function(cat) {
        cat.classList.remove('active');
    });

    if (element) {
        element.classList.add('active');
    }

    selectedCategory = category;

    applyAllFilters();

}


/* =========================================
   VEG / NON-VEG FILTER
   ========================================= */

function filterFoodType(type) {

    selectedFoodType = type;

    applyAllFilters();

    updateFoodButtons();

}


/* =========================================
   SEARCH
   ========================================= */

function searchRestaurants() {

    const searchBox = document.getElementById("searchInput");

    if (searchBox) {

        searchText =
            searchBox.value.toLowerCase().trim();

    }

    applyAllFilters();

}


/* =========================================
   MAIN FILTER
   ========================================= */

function applyAllFilters() {

    const cards =
        document.querySelectorAll(".restaurant-card");


    cards.forEach(function(card) {

        const cuisine =
            (card.getAttribute("data-cuisine") || "")
            .toLowerCase();


        const restaurantNameElement =
            card.querySelector(".card-body h3");


        const restaurantName =
            restaurantNameElement
            ? restaurantNameElement.textContent
                .toLowerCase()
                .trim()
            : "";


        const vegValue =
            (card.getAttribute("data-veg") || "")
            .toLowerCase()
            .trim();


        /* ==============================
           1. CUISINE FILTER
           ============================== */

           /* ==============================
           1. CUISINE FILTER
           ============================== */

           let categoryMatch = true;

           if (selectedCategory !== "All") {

               const category = selectedCategory.toLowerCase();

               if (category === "dosa") {

                   categoryMatch =
                       cuisine.includes("south indian") &&
                       !cuisine.includes("sweet") &&
                       !cuisine.includes("dessert") &&
                       !cuisine.includes("cake") &&
                       !cuisine.includes("coffee") &&
                       !cuisine.includes("cafe");

               } else if (category === "cakes") {

                   categoryMatch =
                       cuisine.includes("cake") ||
                       cuisine.includes("dessert") ||
                       cuisine.includes("sweet");

               } else if (category === "coffee") {

                   categoryMatch =
                       cuisine.includes("coffee") ||
                       cuisine.includes("cafe");

               } else {

                   categoryMatch = cuisine.includes(category);
               }
           }

        /* ==============================
           2. VEG / NON-VEG FILTER
           ============================== */

        let foodTypeMatch = true;


        if (selectedFoodType === "Veg") {

            foodTypeMatch =
                vegValue === "true" ||
                vegValue === "1";

        }

        if (selectedFoodType === "Non-Veg") {

            foodTypeMatch =
                vegValue === "false" ||
                vegValue === "0";

        }

        /* ==============================
           3. SEARCH FILTER
           ============================== */

        let searchMatch = true;


        if (searchText !== "") {

            searchMatch =
                restaurantName.includes(searchText) ||
                cuisine.includes(searchText);

        }


        /* ==============================
           FINAL DECISION
           ============================== */

        if (
            categoryMatch &&
            foodTypeMatch &&
            searchMatch
        ) {

            card.style.display = "";

        } else {

            card.style.display = "none";

        }

    });


    /* ==============================
       HIDE EMPTY SECTIONS
       ============================== */

    const sections =
        document.querySelectorAll(".filter-section");


    sections.forEach(function(section) {

        const sectionCards =
            section.querySelectorAll(".restaurant-card");


        let visibleCards = 0;


        sectionCards.forEach(function(card) {

            if (card.style.display !== "none") {

                visibleCards++;

            }

        });


        if (visibleCards > 0) {

            section.style.display = "";

        } else {

            section.style.display = "none";

        }

    });

}


/* =========================================
   ACTIVE VEG / NON-VEG BUTTON
   ========================================= */

   function updateFoodButtons() {

	    const vegButton = document.getElementById("vegButton");
	    const nonVegButton = document.getElementById("nonVegButton");

	    // Remove active from both
	    if (vegButton) {
	        vegButton.classList.remove("active");
	    }

	    if (nonVegButton) {
	        nonVegButton.classList.remove("active");
	    }

	    // Add active to selected button
	    if (selectedFoodType === "Veg") {

	        if (vegButton) {
	            vegButton.classList.add("active");
	        }

	    } else if (selectedFoodType === "Non-Veg") {

	        if (nonVegButton) {
	            nonVegButton.classList.add("active");
	        }
	    }
	}
	
   document.querySelectorAll(".filters button").forEach(function(button) {

	    button.addEventListener("click", function() {

	        // If this button is already active, turn it off
	        if (this.classList.contains("active")) {
	            this.classList.remove("active");
	        } 
	        
	        // Otherwise, activate this button
	        else {
	            document.querySelectorAll(".filters button").forEach(function(btn) {
	                btn.classList.remove("active");
	            });

	            this.classList.add("active");
	        }

	    });

	});  
   function getUserLocation() {

	    if (!navigator.geolocation) {
	        console.log("Geolocation is not supported by this browser.");
	        return;
	    }

	    navigator.geolocation.getCurrentPosition(
	        function(position) {

	            const latitude = position.coords.latitude;
	            const longitude = position.coords.longitude;

	            console.log("Latitude:", latitude);
	            console.log("Longitude:", longitude);

	            // Convert coordinates into an address
	            fetch(
	                "https://nominatim.openstreetmap.org/reverse?format=json&lat="
	                + latitude
	                + "&lon="
	                + longitude
	            )
	            .then(function(response) {
	                return response.json();
	            })
	            .then(function(data) {

	                const address = data.address || {};

	                const city =
	                    address.city ||
	                    address.town ||
	                    address.municipality ||
	                    address.state_district ||
	                    "Your Location";

	                const area =
	                    address.suburb ||
	                    address.neighbourhood ||
	                    address.residential ||
	                    address.village ||
	                    "";

	                document.getElementById("locCity").textContent = city;

	                document.getElementById("locArea").textContent =
	                    area || "Current location";

	            })
	            .catch(function(error) {
	                console.log("Unable to find address:", error);
	            });

	        },

	        function(error) {

	            console.log("Location permission/error:", error.message);

	        }
	    );
	}


	// Get user's location when page loads
	window.addEventListener("load", function() {
	    getUserLocation();
	});


</script>


</html>