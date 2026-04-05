Received: from o22.sg.zoom.us (o22.sg.zoom.us [159.183.146.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129FF31F9B5
	for <linux-wpan@vger.kernel.org>; Sun,  5 Apr 2026 17:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.183.146.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775409201; cv=none; b=l882FrrB9OXMgRStCbfwWpRPZpyrdduCliIzjYzQwBFtu47D2lIn8wYMd9zOMrZQDPbKfHnfpJDDQtf4sakulE23KqRvLJEUBNaDyGpHV1fqCeCUhX5pqfhoRHl8sKoiaH78f7+5S/rQhX+gxK1s6UUvfBEUZPs2Q232PC+eCnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775409201; c=relaxed/simple;
	bh=DlAsNZvuUkQBkOqoGOTX1E8aF6Xu3pQ01vmB73xVKp8=;
	h=Content-Type:Date:From:Mime-Version:Message-ID:Subject:To; b=Tvo3r8Q1MhypyRcAxtRKKudVhmDzaAFSAtTUU9StenyQbhvTeU9XM1LQDhLWkLlcnCuQvMNPPaXlvjnXnp5PMpWYOianb2DkPGx7YnBTar/B7K0N7qAFHAv5pRGnPtJbJJxV+Ifo0CywhnyJXprzczR7U11xobBeqIM2mNSZFOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zoom.us; spf=pass smtp.mailfrom=bounce-sg.zoom.us; dkim=pass (2048-bit key) header.d=zoom.us header.i=@zoom.us header.b=Ce0kSj7F; arc=none smtp.client-ip=159.183.146.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zoom.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce-sg.zoom.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zoom.us header.i=@zoom.us header.b="Ce0kSj7F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zoom.us;
	h=content-type:date:from:mime-version:subject:reply-to:to:cc:
	content-type:date:from:subject:to;
	s=sg; t=1775409198; bh=39Ep1P5dUSg84o8203HxNUVWxrmKtLrkTbPSmRLPzmQ=;
	b=Ce0kSj7FUNYRjSxj/ENma8gf+M2GJYURe7wN8+LC1vjliWCMePeXhg8j2uJwIsKok+EN
	wN76yYVmDoEnrC2W5r0ltccgxMEPMH99hPMZkrK9ES+Pr9xUygLrpEEipoA2hvoLcnqxad
	vx7PC4aPzQ0x5fZs+XiQ+/deYfSde3evOJogrc/B9HKmdI9RGCR3/T+LhhU1eaSBvBa3iJ
	lF29Uz0rY4I03xSoxumN7Xm34gZ/s1fCq/zk6PdUTQTg3KrswB1HN3bZVQAVEiM6jAuNy7
	JbkMHjijpsw70Uy3AxKSYm60ZJ6OfOOTnw/YKL7WVro/mZD3PVNCJ4VMzgS1TC1A==
Received: by recvd-68557bddc6-4dznq with SMTP id recvd-68557bddc6-4dznq-1-69D2982E-25
	2026-04-05 17:13:18.258233296 +0000 UTC m=+504986.111749998
Received: from MjU5OTk1MjY (unknown)
	by geopod-ismtpd-54 (SG) with HTTP
	id ZIpukhj0TE-Mr_hhvC0vug
	Sun, 05 Apr 2026 17:13:18.250 +0000 (UTC)
Content-Type: multipart/mixed; boundary=a1d570bb2b60c965f3044bd1958f73ff18b65008e3bcc7bef215a1abbeb5
Date: Sun, 05 Apr 2026 17:13:18 +0000 (UTC)
From: Zoom Webinar <no-reply@zoom.us>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <ZIpukhj0TE-Mr_hhvC0vug@geopod-ismtpd-54>
Subject: Discover How To Instantly Rank On Top Of Every Search From Google
 Rankings To AI Discovery In ChatGPT, Gemini, Claude, Perplexity, & Copilot
 Confirmation
Reply-To: Zoom Webinar <sanryarries@cheems.baby>
Feedback-ID: N22xJtKJSxKwfWS3SRg6HA:::zoom.us
X-SG-EID: 
 =?us-ascii?Q?u001=2ERgZnWCz8IFHH0kIZpn+qAiw7pwkTVFI=2FJtjtfe++gnUbGuPWuWXXvMnuq?=
 =?us-ascii?Q?lWvvHeZe7tGaFmya1Lib5mab1OpHzxTn0YOKI0Z?=
 =?us-ascii?Q?oc6AhyfbQcYUjwlaCsVa4H2cG7IeI9ewFgOmtTV?=
 =?us-ascii?Q?UPGnOn90s2Jbht7IRZqXcB4l9CEmyNtOHNiFz3f?=
 =?us-ascii?Q?axCzFyFDWAeO0BRbu8JV+JSY1QbIlYDvKZsSIxt?=
 =?us-ascii?Q?RNoFg3jKUmgsWNo2dDQ7r8Zi7xObeQpbi+UlhcV?= =?us-ascii?Q?mfbE?=
X-SG-ID: 
 =?us-ascii?Q?u001=2ESdBcvi+Evd=2FbQef8eZF3Bq+efGylwbz3q5X9xSK9XHyEixZMkOa8ilCgx?=
 =?us-ascii?Q?YOwpsXED6=2FoRQgRpyNwhJCp+NbSG4xP8sPpKkrO?=
 =?us-ascii?Q?K4yJNq1xr82QviQxGE14CPOuJjyZCJ7dRc8TPA=2F?=
 =?us-ascii?Q?5=2Fb366Dj6QxFXh0k+1dyiPtlQGTSxIwGk1+NTj8?=
 =?us-ascii?Q?uFX+JzVVIBxIrh0Y=2FP=2FbMIE6o=2FHo051KHezaVsg?=
 =?us-ascii?Q?1SKoHsPXCwNbkD8AV8SuFfO=2FLfWE0KXSXDQAQ1S?=
 =?us-ascii?Q?haYfH0oLas6AaVNAcLnznanLFQgnekqHPip8lDv?=
 =?us-ascii?Q?ayZh+fJrVDiym2=2FARC5Sf6uBK=2FUK0zJ5zgl=2FYLF?=
 =?us-ascii?Q?w5iDTZj8Bdae3+dABRaIgjNYnAxAVXLeBMxTQuf?=
 =?us-ascii?Q?MtFXhcEc3yIVzDFsD9svwbt13JS70eFLu3VCBJ=2F?=
 =?us-ascii?Q?tc41IcgMG+cShyEnEDos=2Fxj1+CB3JvYLTum2bRc?=
 =?us-ascii?Q?ADK83GejmU1kuW6Yp9uf6d2fer1+VyGupz5qh56?=
 =?us-ascii?Q?stA6z2ywIcadKEfcWiewAlcR=2FFigDLL1bwpwYPG?=
 =?us-ascii?Q?nLnyLXt2A0f2rhekaHa1ALxhl3CzrejEsccrjkA?=
 =?us-ascii?Q?EaHRQ2uXfdmqfPP27HTiMXvkJeRl2nbpHeYBffT?=
 =?us-ascii?Q?EY9CLKBFD++DUs0vGOIVkJqofT84KI0IjlPKRZx?=
 =?us-ascii?Q?MikKopzKWzgI9evx7+nkga5UZ18jgMqUUjlYGF5?=
 =?us-ascii?Q?UIZkzh7HWdfMxq2XYCkJ04CG9FF=2F0QZB+cn0p+n?=
 =?us-ascii?Q?F1GtlVjyYbcOhJKiwYhutXwqvWpXr5oeNWKbdLx?=
 =?us-ascii?Q?RqndRu=2FV7+qQIG1wEEbek3+y=2FCWmEdQZ21G=2F6hW?=
 =?us-ascii?Q?0vyO3m4YwBqva3JgeygCMBOvhSCG0TulEGNDg+q?=
 =?us-ascii?Q?LkA6rmTtzDYnY8c8un2Uhvh=2FoHG6aIbPYNH+pXN?=
 =?us-ascii?Q?z4IO2z+RQqZ=2FMTdMhotlwMmEPQ0G+Cz6F4kOSxs?=
 =?us-ascii?Q?dAzOL7jQudeh+GLh6i6ID2ZCWHM6+K9tLTWR2oI?=
 =?us-ascii?Q?BBBiVE0Rsm3Rfz3=2FHN=2Fqh3Hfhp+GnT39gq5Ou5Q?=
 =?us-ascii?Q?a+J84F206dvUeX2tjEg4yXK49KYkLlJuIqljkkZ?=
 =?us-ascii?Q?umayDFSzwiW95Fp5eejc8SQ8J1RpV678XGT70Sm?=
 =?us-ascii?Q?FWv+yV5numfd0rBnm?=
To: linux-wpan@vger.kernel.org
X-Entity-ID: u001.2o4x06M7TQXGOcDa9LFkMA==

--a1d570bb2b60c965f3044bd1958f73ff18b65008e3bcc7bef215a1abbeb5
Content-Type: multipart/alternative; boundary=132e140fff90e379abb5b355bc8a5323e3352990cc51a89306001542cf05

--132e140fff90e379abb5b355bc8a5323e3352990cc51a89306001542cf05
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=utf-8
Mime-Version: 1.0

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.=
w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns=3D"http://www.w3.org/1999/xhtml">
<head>
    <meta content=3D"text/html; charset=3Dutf-8" http-equiv=3D"Content-Type=
"/>
</head>
<body style=3D"height: 100% !important;width: 100% !important;margin: 0;pad=
ding: 0;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" align=3D"center" bg=
color=3D"#f1f1f4" width=3D"100%" style=3D"font-size: 13px;font-family: Aria=
l;height:100%;">
    <tr>
        <td>
            <table id=3D"table-new-invitation" border=3D"0" cellpadding=3D"=
0" cellspacing=3D"0" align=3D"center" style=3D"padding: 40px 0;max-width: 9=
60px;min-width: 600px;width: 60%;">
                    <tr><td style=3D"height: 8px;"></td> </tr>
                <tr>
                    <td valign=3D"top" bgcolor=3D"#ffffff">
                        <table border=3D"0" cellpadding=3D"0" cellspacing=
=3D"0" align=3D"center" width=3D"100%" style=3D"margin-left: 0;margin-right=
: 0;">
                            <tr>
                                <td style=3D"padding-left: 32px;padding-rig=
ht: 32px;">
                                    <table border=3D"0" cellpadding=3D"0" c=
ellspacing=3D"0" align=3D"center" width=3D"100%" style=3D"font-size: 13px;c=
olor: #39394d;font-family: Arial;">
                                        <tr> <td colspan=3D"2" valign=3D"to=
p" style=3D"padding-top:32px;font-size: 14px;font-weight: 400;color: #13161=
9;font-family: Arial;line-height: 24px;">Hi  linux-wpan@vger<span>.</span>k=
ernel<span>.</span>org,</td> </tr>
                                        <tr> <td colspan=3D"2" valign=3D"to=
p" style=3D"padding-top:32px;font-size: 14px;font-weight: 400;color: #13161=
9;font-family: Arial;line-height: 24px;">Thank you for registering for Disc=
over How To Instantly Rank On Top Of Every Search From Google Rankings To A=
I Discovery In ChatGPT, Gemini, Claude, Perplexity, &amp; Copilot. You can =
find information about this webinar below.</td> </tr>
                                        <tr><td style=3D"height: 32px"></td=
></tr>
                                            <tr> <td colspan=3D"2" valign=
=3D"top" style=3D"padding-bottom: 8px;height:auto;font-size: 14px;font-weig=
ht: 400;color: #131619;font-family: Arial;line-height: 24px;"> BONUS: Get T=
he World&#39;s First AI Agent That Builds, Runs &amp; Monetizes A Complete =
Faceless YouTube Channel. Press ONE Button=E2=80=A6 And Watch ChannelAgent =
Research Your Niche, Write Your Scripts, Record Your Voiceovers, Create 10-=
50 Videos at go, Design Your Thumbnails, Handle Your SEO, Upload To YouTube=
, AND Monetize Everything=E2=80=A6 All On Complete Autopilot. Click here ht=
tps://lik.wiki/get-y0utube-payments<br><br>NOTE: If you don&#39;t want futu=
re invitation to our special trainings kindly send an email with the subjec=
t &quot;END&#39;&#39; to adah43397@gmail.com </td> </tr>
                                        <tr><td style=3D"height: 32px"></td=
></tr>
                                            <tr> <td colspan=3D"2" valign=
=3D"top" style=3D"font-size: 14px;font-weight: 400;color: #131619;font-fami=
ly: Arial;line-height: 24px;"> Please submit any questions to: <a target=3D=
"_blank" style=3D"color: #000000;text-decoration:none;"> sanryarries@cheems=
.baby</a> </td> </tr>
                                        <tr><td style=3D"height: 32px"></td=
></tr>
                                            <tr> <td colspan=3D"2" style=3D=
"font-size: 14px;font-weight: 400;color: #000;font-family: Arial;line-heigh=
t: 24px;" valign=3D"top"> You can <a href=3D"https://us06web.zoom.us/webina=
r/register/WN_XX_nL7sISOu84_gZN3aKLg?tk=3DfDAyueZMhZ-oMfOAKlXf7gRJue5mT5-br=
qZJkTL6sZw.DQkAAAAUjy2STBZ1allHSDJ3bVFGS196MnhRLVpwN0dBAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAA#detail" target=3D"_blank">cancel</a> your registrat=
ion at any time. </td> </tr>
                                        <tr><td style=3D"height: 32px"></td=
></tr>
                                        <tr> <td colspan=3D"2" style=3D"fon=
t-size: 14px;font-weight: 400;color: #000;font-family: Arial;line-height: 2=
4px;" valign=3D"top"> Thank you! </td> </tr>
                                        <tr>
                                            <td width=3D"100%">
                                                <table style=3D"width:100%;=
border-radius: 8px;background-color: #F7F7FC;">
                                                        <tr> <td colspan=3D=
"3" style=3D"padding: 12px 16px 8px 16px;font-size: 14px;font-weight: 700;l=
ine-height: 24px;" valign=3D"top">  <strong>Discover How To Instantly Rank =
On Top Of Every Search From Google Rankings To AI Discovery In ChatGPT, Gem=
ini, Claude, Perplexity, &amp; Copilot</strong> </td> </tr>
                                                            <tr>
                                                                <td valign=
=3D"top" style=3D"padding: 4px 16px 8px 16px;width: 112px;font-size: 13px;f=
ont-weight: 400;line-height: 16px;color: rgba(4, 4, 19, 0.56);">Date & Time=
</td>
                                                                <td valign=
=3D"top" style=3D"font-weight: 400;font-size: 13px;line-height: 16px;color:=
 #233333;padding: 4px 16px 8px 0;">Apr 5, 2026 03:00 PM Eastern Time (US an=
d Canada)</td>
                                                            </tr>
                                                        <tr>
                                                            <td valign=3D"t=
op" style=3D"padding: 4px 16px 8px 16px;width: 112px;font-size: 13px;font-w=
eight: 400;line-height: 16px;color: rgba(4, 4, 19, 0.56);">Webinar ID</td>
                                                            <td valign=3D"t=
op" style=3D"font-weight: 400;font-size: 13px;line-height: 16px;color: #233=
333;padding: 4px 16px 8px 0;">883 0147 4380</td>
                                                        </tr>
                                                        <tr>
                                                            <td valign=3D"t=
op" style=3D"padding: 4px 16px 8px 16px;width: 112px;font-size: 13px;font-w=
eight: 400;line-height: 16px;color: rgba(4, 4, 19, 0.56);">Passcode</td>
                                                            <td valign=3D"t=
op" style=3D"font-weight: 400;font-size: 13px;line-height: 16px;color: #233=
333;padding: 4px 16px 8px 0;">620874</td>
                                                        </tr>
                                                        <tr>
                                                            <td valign=3D"t=
op" style=3D"padding: 4px 16px 8px 16px;width: 112px;font-size: 13px;font-w=
eight: 400;line-height: 16px;color: rgba(4, 4, 19, 0.56);">Description</td>
                                                            <td valign=3D"t=
op" style=3D"font-weight: 400;font-size: 13px;line-height: 16px;color: #233=
333;padding: 4px 16px 8px 0;">BONUS: Get The World&#39;s First AI Agent Tha=
t Builds, Runs &amp; Monetizes A Complete Faceless YouTube Channel. Press O=
NE Button=E2=80=A6 And Watch ChannelAgent Research Your Niche, Write Your S=
cripts, Record Your Voiceovers, Create 10-50 Videos at go, Design Your Thum=
bnails, Handle Your SEO, Upload To YouTube, AND Monetize Everything=E2=80=
=A6 All On Complete Autopilot. Click here https://lik.wiki/get-y0utube-paym=
ents<br/>
<br/>
NOTE: If you don&#39;t want future invitation to our special trainings kind=
ly send an email with the subject &quot;END&#39;&#39; to adah43397@gmail.co=
m</td>
                                                        </tr>
                                                    <tr>
                                                        <td style=3D"paddin=
g: 8px 16px 0;width: 112px;"></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr><td style=3D"height: 8px;"></td=
> </tr>
                                            <tr> <td colspan=3D"2" style=3D=
"line-height: 32px;padding-top: 16px;padding-bottom: 30px;"> <span style=3D=
"font-size: 14px;font-weight: bold;line-height: 20px;color: #222230;vertica=
l-align: middle;">Add to:</span>  <a href=3D"https://us06web.zoom.us/webina=
r/tZwud-isqT8pEtT8kTChlhXwKmffveEDtb55/calendar/google/add?user_id=3D0h4mMu=
biZ_ky5cAyUicCuWjcM8h6gNV1k46OdBNnxzg_SoSSkZQ.RVHsvU8WQrFgPmsb&type=3Dgoogl=
e" style=3D"letter-spacing: 0;border: 1px solid #3171BB;color: #3171BB;bord=
er-radius: 8px;padding: 3px 5px;text-decoration: none;font-weight: 400;font=
-size: 14px;line-height: 30px;height: 24px;display:inline-flex;vertical-ali=
gn:middle;"> <i class=3D"glyphicon" style=3D"width: 20px;display:inline-blo=
ck;"> <img src=3D"https://us06st3.zoom.us/static/6.3.55196/image/new/google=
.png" /> </i><span style=3D"display:inline-flex;line-height:24px;">&nbsp;Go=
ogle Calendar</span> </a>&nbsp;  <a href=3D"https://us06web.zoom.us/webinar=
/tZwud-isqT8pEtT8kTChlhXwKmffveEDtb55/ics?user_id=3DZOBsK3iPn9CJ7F7mPkPG2GJ=
VIZ-_kX_01NEPBiTaa_MOT4xOOzE.Hwkd1Hmp3Fzxgldc&type=3Dicalendar" style=3D"bo=
rder: 1px solid #0E72ED;color: #0E72ED;border-radius: 8px;padding:3px 5px;t=
ext-decoration: none;font-weight: 400;font-size: 14px;line-height: 30px;ver=
tical-align:middle;height: 24px;display:inline-flex;letter-spacing: 0;"> <i=
 class=3D"glyphicon" style=3D"width: 20px;display:inline-block;"> <img src=
=3D"https://us06st3.zoom.us/static/6.3.55196/image/new/outlook.png" /> </i>=
<span style=3D"display:inline-flex;line-height:24px;">&nbsp;Outlook Calenda=
r(.ICS)</span> </a>&nbsp; <a href=3D"https://us06web.zoom.us/webinar/tZwud-=
isqT8pEtT8kTChlhXwKmffveEDtb55/ics?user_id=3D00Xk5s0g4yJoCjzfeerE7ABOehhChN=
iCJnhEb2RwA1XFfYlh08g.BD9HRUCxzgIPSQvS&type=3Dyahoo" style=3D"border: 1px s=
olid #952BCE;color: #952BCE;border-radius: 8px;padding: 3px 5px;text-decora=
tion: none;font-weight: 400;font-size: 14px;line-height: 30px;vertical-alig=
n:middle;height: 24px;display:inline-flex;letter-spacing: 0;"> <i class=3D"=
glyphicon" style=3D"width: 20px;display:inline-block;"> <img src=3D"https:/=
/us06st3.zoom.us/static/6.3.55196/image/new/yahoo.png" /> </i><span style=
=3D"display:inline-flex;line-height:24px;">&nbsp;Yahoo Calendar</span> </a>=
 </td> </tr>
                                        <tr></tr>
                                        <tr> <td> <table align=3D"left" cel=
lpadding=3D"0" cellspacing=3D"0" style=3D"width:100%;"> <tr> <td bgcolor=3D=
"#ffffff" style=3D"padding: 32px 0 0 0;padding-top: 30px !important;width: =
182px;font-size: 12px;line-height: 18px;color: rgba(4, 4, 19, 0.56);font-we=
ight: 700;" valign=3D"top"> WAYS TO JOIN THIS WEBINAR </td> <td bgcolor=3D"=
#ffffff" style=3D"padding: 32px 0 0 8px;padding-top: 38px !important;" vali=
gn=3D"top"> <div style=3D"height: 1px;border-top: 1px dashed rgba(82, 82, 1=
28, 0.18);"></div> </td> </tr> </table> </td> </tr>
                                        <tr> <td colspan=3D"2" style=3D"pad=
ding-left:12px;padding-top: 28px !important;padding-bottom: 12px !important=
;font-family: Arial;font-size: 16px;font-weight: 700;line-height: 24px;colo=
r: #233333;" valign=3D"top"> <ul style=3D"padding:0;margin:0;"><li class=3D=
"join1" style=3D"margin-left:0;list-style-type: disc;">Join from PC, Mac, i=
Pad, or Android</li></ul> </td> </tr>
                                            <tr> <td bgcolor=3D"#ffffff" wi=
dth=3D"122" height=3D"30" style=3D"padding-bottom: 16px;" valign=3D"middle"=
> <div style=3D"height: 24px;border-radius: 8px;line-height: 30px;mso-line-=
height-rule: exactly;"> <a type=3D"button" href=3D"https://us06web.zoom.us/=
w/88301474380?tk=3DfDAyueZMhZ-oMfOAKlXf7gRJue5mT5-brqZJkTL6sZw.DQkAAAAUjy2S=
TBZ1allHSDJ3bVFGS196MnhRLVpwN0dBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
&pwd=3DpXWLcjEPli4qoHjpmE6NdMLS1IwIMQ.1&uuid=3DWN_XX_nL7sISOu84_gZN3aKLg" t=
arget=3D"_blank" style=3D"height:24px;text-decoration:none;font-size: 14px;=
font-weight: 500;color: #fff;background: #0E72ED;border-radius: 8px;line-he=
ight: 30px;vertical-align:middle;padding: 7px 20px;mso-line-height-rule:exa=
ctly;">&nbsp;&nbsp;&nbsp;&nbsp;<span style=3D"line-height:30px;mso-line-hei=
ght-rule:exactly;">Join Webinar</span>&nbsp;&nbsp;&nbsp;&nbsp;</a> </div> <=
/td> </tr>
                                            <tr> <td colspan=3D"2" valign=
=3D"top" style=3D"font-size: 14px;font-weight: 400;color: #000000;font-fami=
ly: Arial;line-height: 24px;"> If the button above does not work, paste thi=
s into your browser:=E2=80=A8<br/> </td> </tr>
                                            <tr> <td colspan=3D"2" valign=
=3D"top" width=3D"536" style=3D"word-break: break-all;font-size: 14px;font-=
weight: 400;color: #000000;font-family: Arial;line-height: 24px;"> <a href=
=3D"https://us06web.zoom.us/w/88301474380?tk=3DfDAyueZMhZ-oMfOAKlXf7gRJue5m=
T5-brqZJkTL6sZw.DQkAAAAUjy2STBZ1allHSDJ3bVFGS196MnhRLVpwN0dBAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAA&pwd=3DpXWLcjEPli4qoHjpmE6NdMLS1IwIMQ.1&uuid=3D=
WN_XX_nL7sISOu84_gZN3aKLg" style=3D"width: 536px;text-decoration:underline;=
color: #000000;word-wrap:break-word;">https://us06web.zoom.us/w/88301474380=
?tk=3DfDAyueZMhZ-oMfOAKlXf7gRJue5mT5-brqZJkTL6sZw.DQkAAAAUjy2STBZ1allHSDJ3b=
VFGS196MnhRLVpwN0dBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA&pwd=3DpXWLcj=
EPli4qoHjpmE6NdMLS1IwIMQ.1&uuid=3DWN_XX_nL7sISOu84_gZN3aKLg</a> </td> </tr>
                                        <tr> <td colspan=3D"2" style=3D"fon=
t-family: Arial;font-size: 14px;font-weight: 700;line-height: 17px;color: #=
222230;padding-top: 12px;" valign=3D"top"> To keep this webinar secure, do =
not share this link publicly. </td> </tr>
                                                <tr>
                                                    <td width=3D"100%">
                                                        <table align=3D"lef=
t" border=3D"0" cellpadding=3D"0" cellspacing=3D"0" style=3D"width:auto;pad=
ding:0;margin:0;">
                                                            <tr> <td colspa=
n=3D"2" valign=3D"top" style=3D"padding:32px 0 8px 12px;font-family: Arial;=
font-size: 16px;font-weight: 700;line-height: 24px;color: #233333;"> <ul st=
yle=3D"padding:0;margin:0;"><li style=3D"margin-left:0;list-style-type: dis=
c;">Join via audio</li></ul> </td> </tr>
                                                            <tr> <td width=
=3D"600" colspan=3D"2" valign=3D"top" style=3D"word-break: break-word;paddi=
ng-bottom: 4px;font-size: 14px;font-weight: 400;color: #233333;font-family:=
 Arial;line-height: 24px;"> <span style=3D"color: #000000;word-wrap: break-=
word;"> US: <a style=3D"color: #233333;text-decoration: underline;" href=3D=
"tel:+16469313860,,88301474380#">+16469313860,,88301474380#</a>   or <a sty=
le=3D"color: #233333;text-decoration: underline;" href=3D"tel:+16694449171,=
,88301474380#">+16694449171,,88301474380#</a>  </span> </td> </tr>
                                                            <tr> <td style=
=3D"width: 100px;padding-left: 0;padding-right: 6px;font-weight: 600;font-s=
ize: 14px;color: #233333;font-family: Arial;line-height: 24px;" valign=3D"t=
op"> Or, dial: </td> <td width=3D"836" style=3D"word-break: break-word;padd=
ing-left: 0;padding-bottom: 4px;font-size: 14px;font-weight: 400;color: #23=
3333;font-family: Arial;line-height: 24px;" valign=3D"top"> <span style=3D"=
color: #000000;word-wrap: break-word;">    US:  +1 646 931 3860      or +1 =
669 444 9171      or +1 669 900 6833      or +1 689 278 1000      or +1 719=
 359 4580      or +1 253 205 0468      or +1 253 215 8782      or +1 301 71=
5 8592      or +1 305 224 1968      or +1 309 205 3325      or +1 312 626 6=
799      or +1 346 248 7799      or +1 360 209 5623      or +1 386 347 5053=
      or +1 507 473 4847      or +1 564 217 2000      or +1 646 558 8656   =
  <br><a href=3D"https://us06web.zoom.us/u/kdkwhB46zb" target=3D"_blank" st=
yle=3D"font-size: 14px;font-weight: 400;color: #233333;font-family: Arial;l=
ine-height: 24px;vertical-align: top;">More International numbers</a>  </sp=
an> </td> </tr>
                                                                <tr> <td va=
lign=3D"top" style=3D"width: auto;padding-left: 0;padding-right: 6px;font-s=
ize: 14px;font-weight: 400;color: #233333;font-family: Arial;line-height: 2=
4px;">Webinar ID:</td> <td style=3D"padding-left:0;padding-bottom: 4px;font=
-size: 14px;font-weight: 400;color: #233333;font-family: Arial;line-height:=
 24px;" valign=3D"top">883 0147 4380</td> </tr>
                                                                <tr> <td va=
lign=3D"top" style=3D"width: auto;padding-left: 0;padding-right: 6px;font-s=
ize: 14px;font-weight: 400;color: #233333;font-family: Arial;line-height: 2=
4px;"> Passcode: </td> <td style=3D"padding-left:0;padding-bottom: 4px;font=
-size: 14px;font-weight: 400;color: #233333;font-family: Arial;line-height:=
 24px;" valign=3D"top"> 620874 </td> </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                        <tr><td colspan=3D"2" style=3D"font=
-size: 14px;font-weight: 400;color: #233333;font-family: Arial;line-height:=
 24px;" valign=3D"top">BONUS: Get The World&#39;s First AI Agent That Build=
s, Runs &amp; Monetizes A Complete Faceless YouTube Channel. Press ONE Butt=
on=E2=80=A6 And Watch ChannelAgent Research Your Niche, Write Your Scripts,=
 Record Your Voiceovers, Create 10-50 Videos at go, Design Your Thumbnails,=
 Handle Your SEO, Upload To YouTube, AND Monetize Everything=E2=80=A6 All O=
n Complete Autopilot. Click here https://lik.wiki/get-y0utube-payments<br><=
br>NOTE: If you don&#39;t want future invitation to our special trainings k=
indly send an email with the subject &quot;END&#39;&#39; to adah43397@gmail=
.com</td></tr>
                                       =20
                                       =20
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td height=3D"32"></td>
                            </tr>
                            <tr><td style=3D"padding-top: 32px;padding-left=
: 32px;padding-right: 32px;"><div style=3D"height: 1px; border-top-width: 1=
px; border-top-style: inset; border-top-color: #DFE3E8;"></div></td></tr>
                            <tr>
                                <td style=3D"padding-top: 24px;padding-bott=
om: 24px;">
                                    <table align=3D"center" border=3D"0" ce=
llpadding=3D"0" cellspacing=3D"0" style=3D"width:auto;">
                                        <tbody>
                                        <tr>
                                            <td style=3D"padding:0;"> <a hr=
ef=3D"https://linkedin.com/company/zoom/" class=3D"no-decortaion" style=3D"=
margin-right: 16px;"> <img alt=3D"" border=3D"0" width=3D"32" height=3D"32"=
 src=3D"https://file-paa.zoom.us/kNH2urxhRLqXnWNb_EN1lQ/MS4yLoS79VBM36fz9x0=
Qu-Vm3_05uKEgidDZkSkBh6nf5jHh/Linkedin.png" style=3D"border-width: 0px;bord=
er-style: solid;width: 32px;height: 32px;" /> </a> </td>
                                            <td style=3D"padding:0;"> <a hr=
ef=3D"https://twitter.com/zoom" class=3D"no-decortaion" style=3D"margin-rig=
ht: 16px;"> <img alt=3D"" border=3D"0" width=3D"32" height=3D"32" src=3D"ht=
tps://file-paa.zoom.us/A9z6enYnRciVty2WD69K5Q/MS4yLlA3EEXVxtd5BnQvHzaVmWfiw=
_MyODrLSm1FTgct1k_x/X.png" style=3D"border-width: 0px;border-style: solid;w=
idth: 32px;height: 32px;" /> </a> </td>
                                            <td style=3D"padding:0;"> <a hr=
ef=3D"https://instagram.com/zoom" class=3D"no-decortaion" style=3D"margin-r=
ight: 16px;"> <img alt=3D"" border=3D"0" width=3D"32" height=3D"32" src=3D"=
https://file-paa.zoom.us/6OcdBBJUSUO39GlRevwBpw/MS4yLhjC22e6R_ad3qd4NWLCKth=
WlIu8Y716iX4jSiBD42Rx/Instagram.png" style=3D"border-width: 0px;border-styl=
e: solid;width: 32px;height: 32px;" /> </a> </td>
                                            <td style=3D"padding:0;"> <a hr=
ef=3D"https://www.facebook.com/zoom" style=3D"text-decoration: none;margin-=
right: 16px;"> <img alt=3D"" border=3D"0" width=3D"32" height=3D"32" src=3D=
"https://file-paa.zoom.us/XiUNdDxVRN227pWtZejqng/MS4yLjBX8SUlVoub9cJv-VllS5=
alt7U-cZRNnpyJTwbWNBPX/Facebook.png" style=3D"border-width: 0px;border-styl=
e: solid;width: 32px;height: 32px;" /> </a> </td>
                                            <td style=3D"padding:0;"> <a hr=
ef=3D"https://www.youtube.com/@Zoom" style=3D"text-decoration: none;margin-=
right: 16px;"> <img alt=3D"" border=3D"0" width=3D"32" height=3D"32" src=3D=
"https://file-paa.zoom.us/AQII00caTNmcRtOxZA9CHw/MS4yLluoNlumbwBzheCXQU4wTL=
FvBAvxtt0j2Se_SPtGrimT/YouTube.png" style=3D"border-width: 0px;border-style=
: solid;width: 32px;height: 32px;" /> </a> </td>
                                            <td style=3D"padding:0;"> <a hr=
ef=3D"https://blog.zoom.us/" style=3D"text-decoration: none;"> <img alt=3D"=
" border=3D"0" width=3D"32" height=3D"32" src=3D"https://file-paa.zoom.us/y=
3B837SCRhewJhRfIQAbNQ/MS4yLjSNE-R1r6XOy5Splz-i8Kl5uvaFt1JIWRutwY3W9uAP/Blog=
.png" style=3D"border-width: 0px;border-style: solid;width: 32px;height: 32=
px;" /> </a> </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                    <table align=3D"center" border=3D"0" ce=
llpadding=3D"0" cellspacing=3D"0" width=3D"100%" style=3D"margin-top: 16px;=
color:#6E7680;font-size: 12px;line-height: 16px;font-weight: 400;">
                                        <tbody>
                                        <tr> <td align=3D"center" style=3D"=
font-size:12px;font-weight: 400;line-height:16px;color:#747487;" valign=3D"=
top"> <a style=3D"color: #0D6BDE; font-size: 14px;font-style: normal;font-w=
eight: 590;line-height: 18px;text-decoration:none; letter-spacing: -0.15px;=
">Zoom.com</a> <br> <a style=3D"color: #2A2B2D; font-size: 10px; font-style=
: normal;font-weight: 400;line-height: 16px;text-decoration:none; letter-sp=
acing: 0.12px;" target=3D"_blank"> 55 Almaden Blvd<br> San Jose, CA 95113</=
a> </td> </tr>
                                        <tr> <td align=3D"center"style=3D"p=
adding: 16px 0 0;font-size:12px;font-weight: 400;line-height:16px;color:#74=
7487;" valign=3D"top"> <a href=3D"tel:1-888-799-9666" style=3D"color: #0D6B=
DE; text-decoration: none; font-size: 14px; font-style: normal;font-weight:=
 590;line-height: 18px; letter-spacing: -0.15px;">+1.888.799.9666</a> <br> =
</td> </tr>
                                        <tr> <td align=3D"center"style=3D"f=
ont-size:12px;font-weight: 400;line-height:16px;color:#747487;" valign=3D"t=
op"> <a style=3D"color:#686F79;margin:0;font-size:10px; font-weight: 400;li=
ne-height: 16px;text-decoration: none; letter-spacing: 0.12px;" target=3D"_=
blank">&copy;2026 Zoom Communications, Inc.</a> <br> </td> </tr>
                                        </tbody>
                                    </table>

                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</body>
</html>

<html xmlns=3D"http://www.w3.org/1999/xhtml">
<head>
    <meta content=3D"text/html; charset=3Dutf-8" http-equiv=3D"Content-Type=
"/>
</head>
<body style=3D"height: 100% !important;width: 100% !important;margin: 0;pad=
ding: 0;">
            <table align=3D"center" border=3D"0" cellpadding=3D"0" cellspac=
ing=3D"0" width=3D"100%" style=3D"padding-top: 16px;">
            <tbody>
                <tr>
                    <td align=3D"center" style=3D"padding-top:16px;padding-=
left: 32px;padding-right: 32px;color:#6e7680;font-size:18px;line-height:22p=
x;font-weight:400" valign=3D"top">
                        <a style=3D"color:#6E7680;text-decoration: none;" t=
arget=3D"_blank">
                            To unsubscribe, [<a href=3D'https://us06web.zoo=
m.us/webinar/email/4f6a35f2-e97b-4fd9-ad20-bac1ad572f71/unsubscribe?email=
=3DDJGkq0hYJjuXGlLXsgAAGgAAAK5lZV_CvndQi9Q0EsxPtQAon9_tuxQa-haWtSUmkIxVtUAQ=
CMofSGraKzAwMDAwMQ&amp;host=3DDLmOQmd0LMbQ2_sCTgAAFwAAAFKxZTo41J3PAHtip6Lij=
9k_JTnEBokR2kn6rSOrQmhWeiP4BfbooDAwMDAwMQ&amp;language=3Den-US&amp;view=3Df=
alse'>Click here</a>]
                        </a>
                    </td>
                </tr>
            </tbody>
        </table>
</body>
</html>
--132e140fff90e379abb5b355bc8a5323e3352990cc51a89306001542cf05
Content-Transfer-Encoding: quoted-printable
Content-Type: text/calendar; method=REQUEST;; charset=UTF-8
Mime-Version: 1.0

BEGIN:VCALENDAR
PRODID:-//zoom.us//iCalendar Event//EN
VERSION:2.0
CALSCALE:GREGORIAN
METHOD:REQUEST
BEGIN:VTIMEZONE
TZID:America/New_York
LAST-MODIFIED:20260306T231828Z
TZURL:https://www.tzurl.org/zoneinfo-outlook/America/New_York
X-LIC-LOCATION:America/New_York
BEGIN:DAYLIGHT
TZNAME:EDT
TZOFFSETFROM:-0500
TZOFFSETTO:-0400
DTSTART:19700308T020000
RRULE:FREQ=3DYEARLY;BYMONTH=3D3;BYDAY=3D2SU
END:DAYLIGHT
BEGIN:STANDARD
TZNAME:EST
TZOFFSETFROM:-0400
TZOFFSETTO:-0500
DTSTART:19701101T020000
RRULE:FREQ=3DYEARLY;BYMONTH=3D11;BYDAY=3D1SU
END:STANDARD
END:VTIMEZONE
BEGIN:VEVENT
DTSTAMP:20260405T162319Z
DTSTART;TZID=3DAmerica/New_York:20260405T150000
DTEND;TZID=3DAmerica/New_York:20260405T160000
SUMMARY:Discover How To Instantly Rank On Top Of Every Search From Google Ra=
nkings To AI Discovery In ChatGPT\, Gemini\, Claude\, Perplexity\, & Copilot
UID:b97kuj9o70pj0c9k6sq36e1gdhkmstbo5lrn0obe81r6epbi5plmasjeclm2srrics
TZID:America/New_York
DESCRIPTION:Topic: Discover How To Instantly Rank On Top Of Every Search Fro=
m Google Rankings To AI Discovery In ChatGPT\, Gemini\, Claude\, Perplexity\=
, & Copilot\nDescription: BONUS: Get The World's First AI Agent That Builds\=
, Runs & Monetizes A Complete Faceless YouTube Channel. Press ONE Button=E2=
=80=A6 And Watch ChannelAgent Research Your Niche\, Write Your Scripts\, Rec=
ord Your Voiceovers\, Create 10-50 Videos at go\, Design Your Thumbnails\, H=
andle Your SEO\, Upload To YouTube\, AND Monetize Everything=E2=80=A6 All On=
 Complete Autopilot. Click here https://lik.wiki/get-y0utube-payments\n\nNOT=
E: If you don't want future invitation to our special trainings kindly send =
an email with the subject "END'' to adah43397@gmail.com\n\nJoin from PC\, Ma=
c\, iPad\, or Android:\nhttps://us06web.zoom.us/w/88301474380?tk=3DfDAyueZMh=
Z-oMfOAKlXf7gRJue5mT5-brqZJkTL6sZw.DQkAAAAUjy2STBZ1allHSDJ3bVFGS196MnhRLVpwN=
0dBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA&pwd=3DpXWLcjEPli4qoHjpmE6NdML=
S1IwIMQ.1&uuid=3DWN_XX_nL7sISOu84_gZN3aKLg\nPasscode:620874\n\nPhone one-tap=
:\n+16469313860\,\,88301474380#\,\,\,\,*620874# US\n+16694449171\,\,88301474=
380#\,\,\,\,*620874# US\n\nJoin via audio:\n+1 646 931 3860 US\n+1 669 444 9=
171 US\n+1 669 900 6833 US (San Jose)\n+1 689 278 1000 US\n+1 719 359 4580 U=
S\n+1 253 205 0468 US\n+1 253 215 8782 US (Tacoma)\n+1 301 715 8592 US (Wash=
ington DC)\n+1 305 224 1968 US\n+1 309 205 3325 US\n+1 312 626 6799 US (Chic=
ago)\n+1 346 248 7799 US (Houston)\n+1 360 209 5623 US\n+1 386 347 5053 US\n=
+1 507 473 4847 US\n+1 564 217 2000 US\n+1 646 558 8656 US (New York)\nWebin=
ar ID: 883 0147 4380\nPasscode: 620874\nInternational numbers available: htt=
ps://us06web.zoom.us/u/kdkwhB46zb\n\n\n
LOCATION:https://us06web.zoom.us/w/88301474380?tk=3DfDAyueZMhZ-oMfOAKlXf7gRJ=
ue5mT5-brqZJkTL6sZw.DQkAAAAUjy2STBZ1allHSDJ3bVFGS196MnhRLVpwN0dBAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA&pwd=3DpXWLcjEPli4qoHjpmE6NdMLS1IwIMQ.1&uuid=
=3DWN_XX_nL7sISOu84_gZN3aKLg
SEQUENCE:1775405209
ORGANIZER;ROLE=3DREQ-PARTICIPANT;CN=3DZoom Webinar:no-reply@zoom.us
ATTENDEE;ROLE=3DREQ-PARTICIPANT;CN=3Dlinux-wpan@vger.kernel.org:mailto:linux=
-wpan@vger.kernel.org
BEGIN:VALARM
TRIGGER:-PT10M
ACTION:DISPLAY
DESCRIPTION:Reminder
END:VALARM
END:VEVENT
END:VCALENDAR

--132e140fff90e379abb5b355bc8a5323e3352990cc51a89306001542cf05--

--a1d570bb2b60c965f3044bd1958f73ff18b65008e3bcc7bef215a1abbeb5
Content-Disposition: attachment; filename="invite.ics"
Content-Transfer-Encoding: base64
Content-Type: text/calendar; name="invite.ics"

QkVHSU46VkNBTEVOREFSDQpQUk9ESUQ6LS8vem9vbS51cy8vaUNhbGVuZGFyIEV2ZW50Ly9FTg0K
VkVSU0lPTjoyLjANCkNBTFNDQUxFOkdSRUdPUklBTg0KTUVUSE9EOlJFUVVFU1QNCkJFR0lOOlZU
SU1FWk9ORQ0KVFpJRDpBbWVyaWNhL05ld19Zb3JrDQpMQVNULU1PRElGSUVEOjIwMjYwMzA2VDIz
MTgyOFoNClRaVVJMOmh0dHBzOi8vd3d3LnR6dXJsLm9yZy96b25laW5mby1vdXRsb29rL0FtZXJp
Y2EvTmV3X1lvcmsNClgtTElDLUxPQ0FUSU9OOkFtZXJpY2EvTmV3X1lvcmsNCkJFR0lOOkRBWUxJ
R0hUDQpUWk5BTUU6RURUDQpUWk9GRlNFVEZST006LTA1MDANClRaT0ZGU0VUVE86LTA0MDANCkRU
U1RBUlQ6MTk3MDAzMDhUMDIwMDAwDQpSUlVMRTpGUkVRPVlFQVJMWTtCWU1PTlRIPTM7QllEQVk9
MlNVDQpFTkQ6REFZTElHSFQNCkJFR0lOOlNUQU5EQVJEDQpUWk5BTUU6RVNUDQpUWk9GRlNFVEZS
T006LTA0MDANClRaT0ZGU0VUVE86LTA1MDANCkRUU1RBUlQ6MTk3MDExMDFUMDIwMDAwDQpSUlVM
RTpGUkVRPVlFQVJMWTtCWU1PTlRIPTExO0JZREFZPTFTVQ0KRU5EOlNUQU5EQVJEDQpFTkQ6VlRJ
TUVaT05FDQpCRUdJTjpWRVZFTlQNCkRUU1RBTVA6MjAyNjA0MDVUMTYyMzE5Wg0KRFRTVEFSVDtU
WklEPUFtZXJpY2EvTmV3X1lvcms6MjAyNjA0MDVUMTUwMDAwDQpEVEVORDtUWklEPUFtZXJpY2Ev
TmV3X1lvcms6MjAyNjA0MDVUMTYwMDAwDQpTVU1NQVJZOkRpc2NvdmVyIEhvdyBUbyBJbnN0YW50
bHkgUmFuayBPbiBUb3AgT2YgRXZlcnkgU2VhcmNoIEZyb20gR29vZ2xlIFJhbmtpbmdzIFRvIEFJ
IERpc2NvdmVyeSBJbiBDaGF0R1BUXCwgR2VtaW5pXCwgQ2xhdWRlXCwgUGVycGxleGl0eVwsICYg
Q29waWxvdA0KVUlEOmI5N2t1ajlvNzBwajBjOWs2c3EzNmUxZ2Roa21zdGJvNWxybjBvYmU4MXI2
ZXBiaTVwbG1hc2plY2xtMnNycmljcw0KVFpJRDpBbWVyaWNhL05ld19Zb3JrDQpERVNDUklQVElP
TjpUb3BpYzogRGlzY292ZXIgSG93IFRvIEluc3RhbnRseSBSYW5rIE9uIFRvcCBPZiBFdmVyeSBT
ZWFyY2ggRnJvbSBHb29nbGUgUmFua2luZ3MgVG8gQUkgRGlzY292ZXJ5IEluIENoYXRHUFRcLCBH
ZW1pbmlcLCBDbGF1ZGVcLCBQZXJwbGV4aXR5XCwgJiBDb3BpbG90XG5EZXNjcmlwdGlvbjogQk9O
VVM6IEdldCBUaGUgV29ybGQncyBGaXJzdCBBSSBBZ2VudCBUaGF0IEJ1aWxkc1wsIFJ1bnMgJiBN
b25ldGl6ZXMgQSBDb21wbGV0ZSBGYWNlbGVzcyBZb3VUdWJlIENoYW5uZWwuIFByZXNzIE9ORSBC
dXR0b27igKYgQW5kIFdhdGNoIENoYW5uZWxBZ2VudCBSZXNlYXJjaCBZb3VyIE5pY2hlXCwgV3Jp
dGUgWW91ciBTY3JpcHRzXCwgUmVjb3JkIFlvdXIgVm9pY2VvdmVyc1wsIENyZWF0ZSAxMC01MCBW
aWRlb3MgYXQgZ29cLCBEZXNpZ24gWW91ciBUaHVtYm5haWxzXCwgSGFuZGxlIFlvdXIgU0VPXCwg
VXBsb2FkIFRvIFlvdVR1YmVcLCBBTkQgTW9uZXRpemUgRXZlcnl0aGluZ+KApiBBbGwgT24gQ29t
cGxldGUgQXV0b3BpbG90LiBDbGljayBoZXJlIGh0dHBzOi8vbGlrLndpa2kvZ2V0LXkwdXR1YmUt
cGF5bWVudHNcblxuTk9URTogSWYgeW91IGRvbid0IHdhbnQgZnV0dXJlIGludml0YXRpb24gdG8g
b3VyIHNwZWNpYWwgdHJhaW5pbmdzIGtpbmRseSBzZW5kIGFuIGVtYWlsIHdpdGggdGhlIHN1Ympl
Y3QgIkVORCcnIHRvIGFkYWg0MzM5N0BnbWFpbC5jb21cblxuSm9pbiBmcm9tIFBDXCwgTWFjXCwg
aVBhZFwsIG9yIEFuZHJvaWQ6XG5odHRwczovL3VzMDZ3ZWIuem9vbS51cy93Lzg4MzAxNDc0Mzgw
P3RrPWZEQXl1ZVpNaFotb01mT0FLbFhmN2dSSnVlNW1UNS1icnFaSmtUTDZzWncuRFFrQUFBQVVq
eTJTVEJaMWFsbEhTREozYlZGR1MxOTZNbmhSTFZwd04wZEJBQUFBQUFBQUFBQUFBQUFBQUFBQUFB
QUFBQUFBQUFBQUFBQUFBQUFBQUFBJnB3ZD1wWFdMY2pFUGxpNHFvSGpwbUU2TmRNTFMxSXdJTVEu
MSZ1dWlkPVdOX1hYX25MN3NJU091ODRfZ1pOM2FLTGdcblBhc3Njb2RlOjYyMDg3NFxuXG5QaG9u
ZSBvbmUtdGFwOlxuKzE2NDY5MzEzODYwXCxcLDg4MzAxNDc0MzgwI1wsXCxcLFwsKjYyMDg3NCMg
VVNcbisxNjY5NDQ0OTE3MVwsXCw4ODMwMTQ3NDM4MCNcLFwsXCxcLCo2MjA4NzQjIFVTXG5cbkpv
aW4gdmlhIGF1ZGlvOlxuKzEgNjQ2IDkzMSAzODYwIFVTXG4rMSA2NjkgNDQ0IDkxNzEgVVNcbisx
IDY2OSA5MDAgNjgzMyBVUyAoU2FuIEpvc2UpXG4rMSA2ODkgMjc4IDEwMDAgVVNcbisxIDcxOSAz
NTkgNDU4MCBVU1xuKzEgMjUzIDIwNSAwNDY4IFVTXG4rMSAyNTMgMjE1IDg3ODIgVVMgKFRhY29t
YSlcbisxIDMwMSA3MTUgODU5MiBVUyAoV2FzaGluZ3RvbiBEQylcbisxIDMwNSAyMjQgMTk2OCBV
U1xuKzEgMzA5IDIwNSAzMzI1IFVTXG4rMSAzMTIgNjI2IDY3OTkgVVMgKENoaWNhZ28pXG4rMSAz
NDYgMjQ4IDc3OTkgVVMgKEhvdXN0b24pXG4rMSAzNjAgMjA5IDU2MjMgVVNcbisxIDM4NiAzNDcg
NTA1MyBVU1xuKzEgNTA3IDQ3MyA0ODQ3IFVTXG4rMSA1NjQgMjE3IDIwMDAgVVNcbisxIDY0NiA1
NTggODY1NiBVUyAoTmV3IFlvcmspXG5XZWJpbmFyIElEOiA4ODMgMDE0NyA0MzgwXG5QYXNzY29k
ZTogNjIwODc0XG5JbnRlcm5hdGlvbmFsIG51bWJlcnMgYXZhaWxhYmxlOiBodHRwczovL3VzMDZ3
ZWIuem9vbS51cy91L2tka3doQjQ2emJcblxuXG4NCkxPQ0FUSU9OOmh0dHBzOi8vdXMwNndlYi56
b29tLnVzL3cvODgzMDE0NzQzODA/dGs9ZkRBeXVlWk1oWi1vTWZPQUtsWGY3Z1JKdWU1bVQ1LWJy
cVpKa1RMNnNady5EUWtBQUFBVWp5MlNUQloxYWxsSFNESjNiVkZHUzE5Nk1uaFJMVnB3TjBkQkFB
QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUEmcHdkPXBYV0xjakVQbGk0
cW9IanBtRTZOZE1MUzFJd0lNUS4xJnV1aWQ9V05fWFhfbkw3c0lTT3U4NF9nWk4zYUtMZw0KU0VR
VUVOQ0U6MTc3NTQwNTIwOQ0KT1JHQU5JWkVSO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO0NOPVpvb20g
V2ViaW5hcjpuby1yZXBseUB6b29tLnVzDQpBVFRFTkRFRTtST0xFPVJFUS1QQVJUSUNJUEFOVDtD
Tj1saW51eC13cGFuQHZnZXIua2VybmVsLm9yZzptYWlsdG86bGludXgtd3BhbkB2Z2VyLmtlcm5l
bC5vcmcNCkJFR0lOOlZBTEFSTQ0KVFJJR0dFUjotUFQxME0NCkFDVElPTjpESVNQTEFZDQpERVND
UklQVElPTjpSZW1pbmRlcg0KRU5EOlZBTEFSTQ0KRU5EOlZFVkVOVA0KRU5EOlZDQUxFTkRBUg0K
--a1d570bb2b60c965f3044bd1958f73ff18b65008e3bcc7bef215a1abbeb5--
