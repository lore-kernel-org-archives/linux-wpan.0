Received: from o5.sg.zoom.us (o5.sg.zoom.us [149.72.199.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189CC32A3FF
	for <linux-wpan@vger.kernel.org>; Fri, 13 Mar 2026 19:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.72.199.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773431192; cv=none; b=jQTNyocQx7noY3LGLhiFMdFOeYJNNpictFqvAYGoDnZ/UDC5Fp/SKO5ufxd0djUzZZM6ycWKGHdy3mYI/IThNh+oOSHjYlmihBlSv/qWcnjPZm2iYbG4ykpguG4urMZuCUoZa88G79V80HxdVgYFX7cQHUxjtflSyhAQuAClNK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773431192; c=relaxed/simple;
	bh=cufN5x6d1zmrTtgpstO/YxLXS4530IQ4nd13eR3PUtc=;
	h=Content-Type:Date:From:Mime-Version:Message-ID:Subject:To; b=W7xFQ++P58/bDk9WWh/veXlEoxfgptKdfJ5odue955VhLc4auo4PMdoFZaIig+aReX0mjTy82q0Ue0sWfBt/saz1ICXPB/exk4DP6yVO/rzX3BDzPdZKVJCvqG2u22rfz6WkqSNz5nhV0E7DwxrZyBqTUXdKThFpaLq4a7YnEyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zoom.us; spf=pass smtp.mailfrom=bounce-sg.zoom.us; dkim=pass (2048-bit key) header.d=zoom.us header.i=@zoom.us header.b=L8VogIuH; arc=none smtp.client-ip=149.72.199.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zoom.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce-sg.zoom.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zoom.us header.i=@zoom.us header.b="L8VogIuH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zoom.us;
	h=content-type:date:from:mime-version:subject:reply-to:to:cc:
	content-type:date:from:subject:to;
	s=sg; t=1773431189; bh=k7AWIqaIHaKx63q0vfvuL7pDM+djUl0+oXFpB9XSB5Q=;
	b=L8VogIuH82bUmAO3lDY6C6WzY2I5v1xcNsAScAL4w2aySI75Tpc2fNGlWmch1rpBwTKt
	luRqYvFhWv4x8NBGMf4EwwNSacOs6XLLR4FWi26fX36yicQeiBgo0VtWRMbW+HxyaALwdd
	MxQ9crfDDeh/oyxk2tfVa+zIPEC65ASq/+mv0T70I+p2p5KLainhIWRmU05PtdZfKLCKub
	G7kSXqRlyDB40WimC6uObjb6fehHCxKBaWYH7n+XmTO/J404S+tV/Ry1r1i6hlAhR3GOqk
	Anv7tkXIRVVmrQIkBWJMqyAGX88hn+BNfx56hL9bIu0idLEr/0ql0+RjQd9caomw==
Received: by recvd-6f8dfb459c-msngm with SMTP id recvd-6f8dfb459c-msngm-1-69B46995-C3
	2026-03-13 19:46:29.796006776 +0000 UTC m=+347461.649275247
Received: from MjEwNzk4ODQ (unknown)
	by geopod-ismtpd-55 (SG) with HTTP
	id EFsYydkLTnGQuP7V20ccEQ
	Fri, 13 Mar 2026 19:46:29.781 +0000 (UTC)
Content-Type: multipart/mixed; boundary=9fa3a51fe5cb454559359c20d50dc79b73df15cec07d5aca7f0e5b772380
Date: Fri, 13 Mar 2026 19:46:29 +0000 (UTC)
From: Zoom Webinar <no-reply@zoom.us>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <EFsYydkLTnGQuP7V20ccEQ@geopod-ismtpd-55>
Subject: [TODAY @ 3 PM]: How AI =?UTF-8?B?4oCcVmlyYWwgQ2hhcmFjdGVyc+KAnQ==?=
 Are Pulling Millions of Views & Turning Short Videos Into Daily Sales
 Confirmation
Reply-To: Zoom Webinar <lanrejames@novalab.in>
Feedback-ID: j8lyLvjATyKTA8EMIQdvzA:::zoom.us
X-SG-EID: 
 =?us-ascii?Q?u001=2ERgZnWCz8IFHH0kIZpn+qAiw7pwkTVFI=2FJtjtfe++gnUbGuPWuWXXvMnuq?=
 =?us-ascii?Q?lWvvHeZe7tGaFmya1Lib5mab1OpH=2FYONxBNVTGi?=
 =?us-ascii?Q?dSIeMkh1VvHBWskG6s85D6ltjzBNm19+QWkMvwT?=
 =?us-ascii?Q?IyBcoszfNSlmK4BgE3Q0WXma5Bt9MK3oYQRWk4A?=
 =?us-ascii?Q?c+qsExYGsxwaXGMyFo1JA2vqRLDmdUurz3nO5Ln?=
 =?us-ascii?Q?t77lqe+hR=2FVyafeqYEU8Kdnq+4aRdGFYEdoQ4yE?= =?us-ascii?Q?7eZz?=
X-SG-ID: 
 =?us-ascii?Q?u001=2ESdBcvi+Evd=2FbQef8eZF3Bq+efGylwbz3q5X9xSK9XHyEixZMkOa8ilCgx?=
 =?us-ascii?Q?YOwpsXED6=2FoRQgRpyNwhJCp+NbSG4xP8sPpKkrO?=
 =?us-ascii?Q?K4yJNq1xr8196a7nn7YrEzKTMCJt7Z4IA8onDck?=
 =?us-ascii?Q?E9lNoaeGkNxcsxSalq9NKsZ+WkO2hukYlVi05Xh?=
 =?us-ascii?Q?VSx6SmEpqpNAxlpfPfHdaZnveMFHxJOn51r5LAs?=
 =?us-ascii?Q?u0TQ82tQV8gpC2L+EAs8uxufGnq6O1QKNML2yVA?=
 =?us-ascii?Q?r5UKHxKvl6FfZ1LaIqDhp=2F0IXcRcMi1uye4TY3X?=
 =?us-ascii?Q?lmZunt9VTQkap6JIl9UZtr+l+uZM50ZYsilf=2F+D?=
 =?us-ascii?Q?2ZuhMQK5oDbQ06mlpCjBcWPZo=2FijNnc+HCN+Gpk?=
 =?us-ascii?Q?GoczT86zpLF65MRqlAwHMFiLeulzJ54YuCU5FYs?=
 =?us-ascii?Q?+VcwBtk4HTO4GrK3AVHz8pA6=2FKm3cIayIl1JVlY?=
 =?us-ascii?Q?Hw47IKku4Px=2FX7+HnronMv=2FxnMU6j9YoJYAv14L?=
 =?us-ascii?Q?Nn+2NofFgRDCUhDMaP=2FCcqQrlBfHAUpA10y06t4?=
 =?us-ascii?Q?ODlG=2Fjnfzl6TO55t9bnnD6PDHlDm4RdCESkjUxu?=
 =?us-ascii?Q?lne7Az7nTx+rou7Q0qTKRIoXVmdOneY1zQIPM1B?=
 =?us-ascii?Q?9jQFWU4rqG4J9iyL1qnaXg51EPid7ViwY7jaxXH?=
 =?us-ascii?Q?kOIoxZw1EZDpkbOnmYH2cL3q=2FmAVPV+vYO0gEIC?=
 =?us-ascii?Q?i=2FFYjydVb1od4wA+RIHxBSEAGN6D4ew57Voldhq?=
 =?us-ascii?Q?CaSTbhq0KVE+pScZ4ekThOz1U0AWXFYEgKlsK8l?=
 =?us-ascii?Q?33PjcYrFnUbqE0AOrpBrgG9Z9KvmSxpLFR008e4?=
 =?us-ascii?Q?f=2Fk04RT21e7R4fXCeDqTFIQ6WAJ7eGzV0w6on0d?=
 =?us-ascii?Q?96ZsWw+rczTyW0l+3yRYyODskC5KgQxvAfkTb0X?=
 =?us-ascii?Q?1FHP0F+BCgNpks4igT9Ohmcbad5AqPfTGrI=2FbM7?=
 =?us-ascii?Q?+hwBq0b9+V5rUHyxIVdwxn6O7c94mniWG4GHpli?=
 =?us-ascii?Q?taZXNsrh5xMOgYCXC2Me7JZyu2phbP5UdKg4pxL?=
 =?us-ascii?Q?VFU5ZDNZwuz7=2FzpqJF2z1eIoZ6EbEp738RFEmlu?=
 =?us-ascii?Q?Lliab9+S3P5S0AtdmtpZYytnyaE6nUWi1ALt9NO?=
 =?us-ascii?Q?W0Vgq3aKyTPTS2fez?=
To: linux-wpan@vger.kernel.org
X-Entity-ID: u001.D04ToUD6XUHaWjLaA2+xDg==

--9fa3a51fe5cb454559359c20d50dc79b73df15cec07d5aca7f0e5b772380
Content-Type: multipart/alternative; boundary=5aa021d6a3b029656997e57f829dd780f434b09ebd2f88d53925de2a7230

--5aa021d6a3b029656997e57f829dd780f434b09ebd2f88d53925de2a7230
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
9;font-family: Arial;line-height: 24px;">Hi  Friend,</td> </tr>
                                        <tr> <td colspan=3D"2" valign=3D"to=
p" style=3D"padding-top:32px;font-size: 14px;font-weight: 400;color: #13161=
9;font-family: Arial;line-height: 24px;">Thank you for registering for [TOD=
AY @ 3 PM]<span>:</span> How AI =E2=80=9CViral Characters=E2=80=9D Are Pull=
ing Millions of Views &amp; Turning Short Videos Into Daily Sales. You can =
find information about this webinar below.</td> </tr>
                                        <tr><td style=3D"height: 32px"></td=
></tr>
                                        <tr><td style=3D"height: 32px"></td=
></tr>
                                            <tr> <td colspan=3D"2" valign=
=3D"top" style=3D"font-size: 14px;font-weight: 400;color: #131619;font-fami=
ly: Arial;line-height: 24px;"> Please submit any questions to: <a target=3D=
"_blank" style=3D"color: #000000;text-decoration:none;"> lanrejames@novalab=
.in</a> </td> </tr>
                                        <tr><td style=3D"height: 32px"></td=
></tr>
                                            <tr> <td colspan=3D"2" style=3D=
"font-size: 14px;font-weight: 400;color: #000;font-family: Arial;line-heigh=
t: 24px;" valign=3D"top"> You can <a href=3D"https://zoom.us/webinar/regist=
er/WN_7OWkX7BxTwuKEaEuvulYxA?tk=3D-J76O4hIQfFiWGb0x0XpJVyjBYy9vXuTpCgJUHsWG=
J0.DQkAAAAVfMDRTRZDNUQ1SzZMMVFlMlhOby1FY1ZTbUpnAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAA#detail" target=3D"_blank">cancel</a> your registration at a=
ny time. </td> </tr>
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
ine-height: 24px;" valign=3D"top">  <strong>[TODAY @ 3 PM]<span>:</span> Ho=
w AI =E2=80=9CViral Characters=E2=80=9D Are Pulling Millions of Views &amp;=
 Turning Short Videos Into Daily Sales</strong> </td> </tr>
                                                            <tr>
                                                                <td valign=
=3D"top" style=3D"padding: 4px 16px 8px 16px;width: 112px;font-size: 13px;f=
ont-weight: 400;line-height: 16px;color: rgba(4, 4, 19, 0.56);">Date & Time=
</td>
                                                                <td valign=
=3D"top" style=3D"font-weight: 400;font-size: 13px;line-height: 16px;color:=
 #233333;padding: 4px 16px 8px 0;">Mar 13, 2026 03:00 PM Eastern Time (US a=
nd Canada)</td>
                                                            </tr>
                                                        <tr>
                                                            <td valign=3D"t=
op" style=3D"padding: 4px 16px 8px 16px;width: 112px;font-size: 13px;font-w=
eight: 400;line-height: 16px;color: rgba(4, 4, 19, 0.56);">Webinar ID</td>
                                                            <td valign=3D"t=
op" style=3D"font-weight: 400;font-size: 13px;line-height: 16px;color: #233=
333;padding: 4px 16px 8px 0;">922 8732 4493</td>
                                                        </tr>
                                                        <tr>
                                                            <td valign=3D"t=
op" style=3D"padding: 4px 16px 8px 16px;width: 112px;font-size: 13px;font-w=
eight: 400;line-height: 16px;color: rgba(4, 4, 19, 0.56);">Description</td>
                                                            <td valign=3D"t=
op" style=3D"font-weight: 400;font-size: 13px;line-height: 16px;color: #233=
333;padding: 4px 16px 8px 0;">Something BIG is about to hit the AI content =
creation space=E2=80=A6<br/>
<br/>
For the first time ever, you=E2=80=99re about to discover a powerful system=
 that lets anyone create viral AI character videos in minutes without compl=
icated editing, animation skills, or expensive software.<br/>
<br/>
Inside this live training, you=E2=80=99ll see how simple ideas, scripts, or=
 images can instantly be transformed into fully animated character videos w=
ith voiceovers, expressions, and storytelling built in automatically.<br/>
<br/>
These character-driven videos are dominating social platforms because audie=
nces connect with characters far more than ordinary content, which is why c=
reators are generating massive engagement using this format.<br/>
<br/>
During this LIVE session, you=E2=80=99ll discover:<br/>
<br/>
=E2=80=A2 How AI characters can instantly generate engaging videos for TikT=
ok, Instagram Reels, and YouTube Shorts<br/>
=E2=80=A2 The simple workflow that transforms ideas, images, or scripts int=
o animated viral videos<br/>
=E2=80=A2 How character-based content grabs attention and keeps viewers wat=
ching longer<br/>
=E2=80=A2 The strategy behind viral character storytelling that drives shar=
es and engagement<br/>
=E2=80=A2 How beginners are using AI characters to create entertaining, hig=
hly shareable videos at scale<br/>
<br/>
You=E2=80=99ll also see a live demo showing exactly how these AI characters=
 can speak, react, and tell stories while automatically syncing voice, expr=
essions, and scenes.<br/>
<br/>
If you want to learn how the new wave of AI-powered viral character videos =
are being created=E2=80=A6<br/>
<br/>
you won=E2=80=99t want to miss this training.<br/>
<br/>
=E2=9A=A0=EF=B8=8F IMPORTANT =E2=80=94 Secure Your Reminder Now!<br/>
<br/>
This is a live training and space is limited.<br/>
<br/>
To make sure you don=E2=80=99t miss it:<br/>
<br/>
=E2=9C=85 Click =E2=80=9CAdd to Calendar=E2=80=9D below to save the event t=
o your Google / Outlook calendar.<br/>
<br/>
Your device will automatically remind you before we go live.<br/>
<br/>
Most people miss live trainings simply because they forget.<br/>
<br/>
Don=E2=80=99t be that person.</td>
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
l-align: middle;">Add to:</span>  <a href=3D"https://zoom.us/webinar/tJYvf-=
6rrD8uE9cVJcfwBOyFHAZcfcmFSa8i/calendar/google/add?user_id=3DjIxKuO-FF9nkjH=
6-KUKTOyndH0k5SOsF2I0Mg31NxHjuRBFwSkQ.1AcrfnjPMW0o7QGd&type=3Dgoogle" style=
=3D"letter-spacing: 0;border: 1px solid #3171BB;color: #3171BB;border-radiu=
s: 8px;padding: 3px 5px;text-decoration: none;font-weight: 400;font-size: 1=
4px;line-height: 30px;height: 24px;display:inline-flex;vertical-align:middl=
e;"> <i class=3D"glyphicon" style=3D"width: 20px;display:inline-block;"> <i=
mg src=3D"https://st3.zoom.us/static/6.3.53910/image/new/google.png" /> </i=
><span style=3D"display:inline-flex;line-height:24px;">&nbsp;Google Calenda=
r</span> </a>&nbsp;  <a href=3D"https://zoom.us/webinar/tJYvf-6rrD8uE9cVJcf=
wBOyFHAZcfcmFSa8i/ics?user_id=3D1dhzA7KgfAcNLxIesFPE0tf9RQIjgYbVli5cH10C8Bf=
csVmD3IE.cdj0zHqWjN2eKTex&type=3Dicalendar" style=3D"border: 1px solid #0E7=
2ED;color: #0E72ED;border-radius: 8px;padding:3px 5px;text-decoration: none=
;font-weight: 400;font-size: 14px;line-height: 30px;vertical-align:middle;h=
eight: 24px;display:inline-flex;letter-spacing: 0;"> <i class=3D"glyphicon"=
 style=3D"width: 20px;display:inline-block;"> <img src=3D"https://st3.zoom.=
us/static/6.3.53910/image/new/outlook.png" /> </i><span style=3D"display:in=
line-flex;line-height:24px;">&nbsp;Outlook Calendar(.ICS)</span> </a>&nbsp;=
 <a href=3D"https://zoom.us/webinar/tJYvf-6rrD8uE9cVJcfwBOyFHAZcfcmFSa8i/ic=
s?user_id=3D7UliufxpEwQ39xPYvMLrJxZmpuAtDE6o5zXP97D4gGk412uV7Nw._vmUJV7Q-N7=
7Y3U3&type=3Dyahoo" style=3D"border: 1px solid #952BCE;color: #952BCE;borde=
r-radius: 8px;padding: 3px 5px;text-decoration: none;font-weight: 400;font-=
size: 14px;line-height: 30px;vertical-align:middle;height: 24px;display:inl=
ine-flex;letter-spacing: 0;"> <i class=3D"glyphicon" style=3D"width: 20px;d=
isplay:inline-block;"> <img src=3D"https://st3.zoom.us/static/6.3.53910/ima=
ge/new/yahoo.png" /> </i><span style=3D"display:inline-flex;line-height:24p=
x;">&nbsp;Yahoo Calendar</span> </a> </td> </tr>
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
height-rule: exactly;"> <a type=3D"button" href=3D"https://zoom.us/w/922873=
24493?tk=3D-J76O4hIQfFiWGb0x0XpJVyjBYy9vXuTpCgJUHsWGJ0.DQkAAAAVfMDRTRZDNUQ1=
SzZMMVFlMlhOby1FY1ZTbUpnAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA&uuid=3D=
WN_7OWkX7BxTwuKEaEuvulYxA" target=3D"_blank" style=3D"height:24px;text-deco=
ration:none;font-size: 14px;font-weight: 500;color: #fff;background: #0E72E=
D;border-radius: 8px;line-height: 30px;vertical-align:middle;padding: 7px 2=
0px;mso-line-height-rule:exactly;">&nbsp;&nbsp;&nbsp;&nbsp;<span style=3D"l=
ine-height:30px;mso-line-height-rule:exactly;">Join Webinar</span>&nbsp;&nb=
sp;&nbsp;&nbsp;</a> </div> </td> </tr>
                                            <tr> <td colspan=3D"2" valign=
=3D"top" style=3D"font-size: 14px;font-weight: 400;color: #000000;font-fami=
ly: Arial;line-height: 24px;"> If the button above does not work, paste thi=
s into your browser:=E2=80=A8<br/> </td> </tr>
                                            <tr> <td colspan=3D"2" valign=
=3D"top" width=3D"536" style=3D"word-break: break-all;font-size: 14px;font-=
weight: 400;color: #000000;font-family: Arial;line-height: 24px;"> <a href=
=3D"https://zoom.us/w/92287324493?tk=3D-J76O4hIQfFiWGb0x0XpJVyjBYy9vXuTpCgJ=
UHsWGJ0.DQkAAAAVfMDRTRZDNUQ1SzZMMVFlMlhOby1FY1ZTbUpnAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAA&uuid=3DWN_7OWkX7BxTwuKEaEuvulYxA" style=3D"width: 536p=
x;text-decoration:underline;color: #000000;word-wrap:break-word;">https://z=
oom.us/w/92287324493?tk=3D-J76O4hIQfFiWGb0x0XpJVyjBYy9vXuTpCgJUHsWGJ0.DQkAA=
AAVfMDRTRZDNUQ1SzZMMVFlMlhOby1FY1ZTbUpnAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAA&uuid=3DWN_7OWkX7BxTwuKEaEuvulYxA</a> </td> </tr>
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
"tel:+13462487799,,92287324493#">+13462487799,,92287324493#</a>   or <a sty=
le=3D"color: #233333;text-decoration: underline;" href=3D"tel:+13602095623,=
,92287324493#">+13602095623,,92287324493#</a>  </span> </td> </tr>
                                                            <tr> <td style=
=3D"width: 100px;padding-left: 0;padding-right: 6px;font-weight: 600;font-s=
ize: 14px;color: #233333;font-family: Arial;line-height: 24px;" valign=3D"t=
op"> Or, dial: </td> <td width=3D"836" style=3D"word-break: break-word;padd=
ing-left: 0;padding-bottom: 4px;font-size: 14px;font-weight: 400;color: #23=
3333;font-family: Arial;line-height: 24px;" valign=3D"top"> <span style=3D"=
color: #000000;word-wrap: break-word;">    US:  +1 346 248 7799      or +1 =
360 209 5623      or +1 386 347 5053      or +1 507 473 4847      or +1 564=
 217 2000      or +1 646 931 3860      or +1 669 444 9171      or +1 669 90=
0 6833      or +1 689 278 1000      or +1 719 359 4580      or +1 929 205 6=
099      or +1 253 205 0468      or +1 253 215 8782      or +1 301 715 8592=
      or +1 305 224 1968      or +1 309 205 3325      or +1 312 626 6799   =
  <br><a href=3D"https://zoom.us/u/ac9hEmcTMT" target=3D"_blank" style=3D"f=
ont-size: 14px;font-weight: 400;color: #233333;font-family: Arial;line-heig=
ht: 24px;vertical-align: top;">More International numbers</a>  </span> </td=
> </tr>
                                                                <tr> <td va=
lign=3D"top" style=3D"width: auto;padding-left: 0;padding-right: 6px;font-s=
ize: 14px;font-weight: 400;color: #233333;font-family: Arial;line-height: 2=
4px;">Webinar ID:</td> <td style=3D"padding-left:0;padding-bottom: 4px;font=
-size: 14px;font-weight: 400;color: #233333;font-family: Arial;line-height:=
 24px;" valign=3D"top">922 8732 4493</td> </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                       =20
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
                            To unsubscribe, [<a href=3D'https://zoom.us/web=
inar/email/3184ad23-db8d-471d-93c5-d6839dac2f92/unsubscribe?email=3DDKdGgGW=
KNd7cdkbPewAAGgAAAIUlwp_uXYGsfchfsEqEdYlzW7NGad851rOkx_LCopUFEaFmIw6Ymka_Tz=
AwMDAwMQ&amp;host=3DDHCHVKhoarK4QtqicgAAFQAAAHcf0AxHPRxKG59bhx3tK28X47Jmnlx=
E1Yw7qxOGu89BX37yw7UwMDAwMDE&amp;language=3Den-US&amp;view=3Dfalse'>Click h=
ere</a>]
                        </a>
                    </td>
                </tr>
            </tbody>
        </table>
</body>
</html>
--5aa021d6a3b029656997e57f829dd780f434b09ebd2f88d53925de2a7230
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
DTSTAMP:20260313T192515Z
DTSTART;TZID=3DAmerica/New_York:20260313T150000
DTEND;TZID=3DAmerica/New_York:20260313T160000
SUMMARY:[TODAY @ 3 PM]: How AI =E2=80=9CViral Characters=E2=80=9D Are Pullin=
g Millions of Views & Turning Short Videos Into Daily Sales
UID:b97kuj9p68p3gdpj68q38e9jdhkmstbo5lrn0obe81r6epbi5plmasjeclm2srrics
TZID:America/New_York
DESCRIPTION:Topic: [TODAY @ 3 PM]: How AI =E2=80=9CViral Characters=E2=80=9D=
 Are Pulling Millions of Views & Turning Short Videos Into Daily Sales\nDesc=
ription: Something BIG is about to hit the AI content creation space=E2=80=
=A6\n\nFor the first time ever\, you=E2=80=99re about to discover a powerful=
 system that lets anyone create viral AI character videos in minutes without=
 complicated editing\, animation skills\, or expensive software.\n\nInside t=
his live training\, you=E2=80=99ll see how simple ideas\, scripts\, or image=
s can instantly be transformed into fully animated character videos with voi=
ceovers\, expressions\, and storytelling built in automatically.\n\nThese ch=
aracter-driven videos are dominating social platforms because audiences conn=
ect with characters far more than ordinary content\, which is why creators a=
re generating massive engagement using this format.\n\nDuring this LIVE sess=
ion\, you=E2=80=99ll discover:\n\n=E2=80=A2 How AI characters can instantly =
generate engaging videos for TikTok\, Instagram Reels\, and YouTube Shorts\n=
=E2=80=A2 The simple workflow that transforms ideas\, images\, or scripts in=
to animated viral videos\n=E2=80=A2 How character-based content grabs attent=
ion and keeps viewers watching longer\n=E2=80=A2 The strategy behind viral c=
haracter storytelling that drives shares and engagement\n=E2=80=A2 How begin=
ners are using AI characters to create entertaining\, highly shareable video=
s at scale\n\nYou=E2=80=99ll also see a live demo showing exactly how these =
AI characters can speak\, react\, and tell stories while automatically synci=
ng voice\, expressions\, and scenes.\n\nIf you want to learn how the new wav=
e of AI-powered viral character videos are being created=E2=80=A6\n\nyou won=
=E2=80=99t want to miss this training.\n\n=E2=9A=A0=EF=B8=8F IMPORTANT =E2=
=80=94 Secure Your Reminder Now!\n\nThis is a live training and space is lim=
ited.\n\nTo make sure you don=E2=80=99t miss it:\n\n=E2=9C=85 Click =E2=80=
=9CAdd to Calendar=E2=80=9D below to save the event to your Google / Outlook=
 calendar.\n\nYour device will automatically remind you before we go live.\n=
\nMost people miss live trainings simply because they forget.\n\nDon=E2=80=
=99t be that person.\n\nJoin from PC\, Mac\, iPad\, or Android:\nhttps://zoo=
m.us/w/92287324493?tk=3D-J76O4hIQfFiWGb0x0XpJVyjBYy9vXuTpCgJUHsWGJ0.DQkAAAAV=
fMDRTRZDNUQ1SzZMMVFlMlhOby1FY1ZTbUpnAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAA&uuid=3DWN_7OWkX7BxTwuKEaEuvulYxA\n\nPhone one-tap:\n+13462487799\,\,9228=
7324493# US (Houston)\n+13602095623\,\,92287324493# US\n\nJoin via audio:\n+=
1 346 248 7799 US (Houston)\n+1 360 209 5623 US\n+1 386 347 5053 US\n+1 507 =
473 4847 US\n+1 564 217 2000 US\n+1 646 931 3860 US\n+1 669 444 9171 US\n+1 =
669 900 6833 US (San Jose)\n+1 689 278 1000 US\n+1 719 359 4580 US\n+1 929 2=
05 6099 US (New York)\n+1 253 205 0468 US\n+1 253 215 8782 US (Tacoma)\n+1 3=
01 715 8592 US (Washington DC)\n+1 305 224 1968 US\n+1 309 205 3325 US\n+1 3=
12 626 6799 US (Chicago)\nWebinar ID: 922 8732 4493\nInternational numbers a=
vailable: https://zoom.us/u/ac9hEmcTMT\n\n\n
LOCATION:https://zoom.us/w/92287324493?tk=3D-J76O4hIQfFiWGb0x0XpJVyjBYy9vXuT=
pCgJUHsWGJ0.DQkAAAAVfMDRTRZDNUQ1SzZMMVFlMlhOby1FY1ZTbUpnAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAA&uuid=3DWN_7OWkX7BxTwuKEaEuvulYxA
SEQUENCE:1773423967
ORGANIZER;ROLE=3DREQ-PARTICIPANT;CN=3DZoom Webinar:no-reply@zoom.us
ATTENDEE;ROLE=3DREQ-PARTICIPANT;CN=3DFriend:mailto:linux-wpan@vger.kernel.or=
g
BEGIN:VALARM
TRIGGER:-PT10M
ACTION:DISPLAY
DESCRIPTION:Reminder
END:VALARM
END:VEVENT
END:VCALENDAR

--5aa021d6a3b029656997e57f829dd780f434b09ebd2f88d53925de2a7230--

--9fa3a51fe5cb454559359c20d50dc79b73df15cec07d5aca7f0e5b772380
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
TUVaT05FDQpCRUdJTjpWRVZFTlQNCkRUU1RBTVA6MjAyNjAzMTNUMTkyNTE1Wg0KRFRTVEFSVDtU
WklEPUFtZXJpY2EvTmV3X1lvcms6MjAyNjAzMTNUMTUwMDAwDQpEVEVORDtUWklEPUFtZXJpY2Ev
TmV3X1lvcms6MjAyNjAzMTNUMTYwMDAwDQpTVU1NQVJZOltUT0RBWSBAIDMgUE1dOiBIb3cgQUkg
4oCcVmlyYWwgQ2hhcmFjdGVyc+KAnSBBcmUgUHVsbGluZyBNaWxsaW9ucyBvZiBWaWV3cyAmIFR1
cm5pbmcgU2hvcnQgVmlkZW9zIEludG8gRGFpbHkgU2FsZXMNClVJRDpiOTdrdWo5cDY4cDNnZHBq
NjhxMzhlOWpkaGttc3RibzVscm4wb2JlODFyNmVwYmk1cGxtYXNqZWNsbTJzcnJpY3MNClRaSUQ6
QW1lcmljYS9OZXdfWW9yaw0KREVTQ1JJUFRJT046VG9waWM6IFtUT0RBWSBAIDMgUE1dOiBIb3cg
QUkg4oCcVmlyYWwgQ2hhcmFjdGVyc+KAnSBBcmUgUHVsbGluZyBNaWxsaW9ucyBvZiBWaWV3cyAm
IFR1cm5pbmcgU2hvcnQgVmlkZW9zIEludG8gRGFpbHkgU2FsZXNcbkRlc2NyaXB0aW9uOiBTb21l
dGhpbmcgQklHIGlzIGFib3V0IHRvIGhpdCB0aGUgQUkgY29udGVudCBjcmVhdGlvbiBzcGFjZeKA
plxuXG5Gb3IgdGhlIGZpcnN0IHRpbWUgZXZlclwsIHlvdeKAmXJlIGFib3V0IHRvIGRpc2NvdmVy
IGEgcG93ZXJmdWwgc3lzdGVtIHRoYXQgbGV0cyBhbnlvbmUgY3JlYXRlIHZpcmFsIEFJIGNoYXJh
Y3RlciB2aWRlb3MgaW4gbWludXRlcyB3aXRob3V0IGNvbXBsaWNhdGVkIGVkaXRpbmdcLCBhbmlt
YXRpb24gc2tpbGxzXCwgb3IgZXhwZW5zaXZlIHNvZnR3YXJlLlxuXG5JbnNpZGUgdGhpcyBsaXZl
IHRyYWluaW5nXCwgeW914oCZbGwgc2VlIGhvdyBzaW1wbGUgaWRlYXNcLCBzY3JpcHRzXCwgb3Ig
aW1hZ2VzIGNhbiBpbnN0YW50bHkgYmUgdHJhbnNmb3JtZWQgaW50byBmdWxseSBhbmltYXRlZCBj
aGFyYWN0ZXIgdmlkZW9zIHdpdGggdm9pY2VvdmVyc1wsIGV4cHJlc3Npb25zXCwgYW5kIHN0b3J5
dGVsbGluZyBidWlsdCBpbiBhdXRvbWF0aWNhbGx5LlxuXG5UaGVzZSBjaGFyYWN0ZXItZHJpdmVu
IHZpZGVvcyBhcmUgZG9taW5hdGluZyBzb2NpYWwgcGxhdGZvcm1zIGJlY2F1c2UgYXVkaWVuY2Vz
IGNvbm5lY3Qgd2l0aCBjaGFyYWN0ZXJzIGZhciBtb3JlIHRoYW4gb3JkaW5hcnkgY29udGVudFws
IHdoaWNoIGlzIHdoeSBjcmVhdG9ycyBhcmUgZ2VuZXJhdGluZyBtYXNzaXZlIGVuZ2FnZW1lbnQg
dXNpbmcgdGhpcyBmb3JtYXQuXG5cbkR1cmluZyB0aGlzIExJVkUgc2Vzc2lvblwsIHlvdeKAmWxs
IGRpc2NvdmVyOlxuXG7igKIgSG93IEFJIGNoYXJhY3RlcnMgY2FuIGluc3RhbnRseSBnZW5lcmF0
ZSBlbmdhZ2luZyB2aWRlb3MgZm9yIFRpa1Rva1wsIEluc3RhZ3JhbSBSZWVsc1wsIGFuZCBZb3VU
dWJlIFNob3J0c1xu4oCiIFRoZSBzaW1wbGUgd29ya2Zsb3cgdGhhdCB0cmFuc2Zvcm1zIGlkZWFz
XCwgaW1hZ2VzXCwgb3Igc2NyaXB0cyBpbnRvIGFuaW1hdGVkIHZpcmFsIHZpZGVvc1xu4oCiIEhv
dyBjaGFyYWN0ZXItYmFzZWQgY29udGVudCBncmFicyBhdHRlbnRpb24gYW5kIGtlZXBzIHZpZXdl
cnMgd2F0Y2hpbmcgbG9uZ2VyXG7igKIgVGhlIHN0cmF0ZWd5IGJlaGluZCB2aXJhbCBjaGFyYWN0
ZXIgc3Rvcnl0ZWxsaW5nIHRoYXQgZHJpdmVzIHNoYXJlcyBhbmQgZW5nYWdlbWVudFxu4oCiIEhv
dyBiZWdpbm5lcnMgYXJlIHVzaW5nIEFJIGNoYXJhY3RlcnMgdG8gY3JlYXRlIGVudGVydGFpbmlu
Z1wsIGhpZ2hseSBzaGFyZWFibGUgdmlkZW9zIGF0IHNjYWxlXG5cbllvdeKAmWxsIGFsc28gc2Vl
IGEgbGl2ZSBkZW1vIHNob3dpbmcgZXhhY3RseSBob3cgdGhlc2UgQUkgY2hhcmFjdGVycyBjYW4g
c3BlYWtcLCByZWFjdFwsIGFuZCB0ZWxsIHN0b3JpZXMgd2hpbGUgYXV0b21hdGljYWxseSBzeW5j
aW5nIHZvaWNlXCwgZXhwcmVzc2lvbnNcLCBhbmQgc2NlbmVzLlxuXG5JZiB5b3Ugd2FudCB0byBs
ZWFybiBob3cgdGhlIG5ldyB3YXZlIG9mIEFJLXBvd2VyZWQgdmlyYWwgY2hhcmFjdGVyIHZpZGVv
cyBhcmUgYmVpbmcgY3JlYXRlZOKAplxuXG55b3Ugd29u4oCZdCB3YW50IHRvIG1pc3MgdGhpcyB0
cmFpbmluZy5cblxu4pqg77iPIElNUE9SVEFOVCDigJQgU2VjdXJlIFlvdXIgUmVtaW5kZXIgTm93
IVxuXG5UaGlzIGlzIGEgbGl2ZSB0cmFpbmluZyBhbmQgc3BhY2UgaXMgbGltaXRlZC5cblxuVG8g
bWFrZSBzdXJlIHlvdSBkb27igJl0IG1pc3MgaXQ6XG5cbuKchSBDbGljayDigJxBZGQgdG8gQ2Fs
ZW5kYXLigJ0gYmVsb3cgdG8gc2F2ZSB0aGUgZXZlbnQgdG8geW91ciBHb29nbGUgLyBPdXRsb29r
IGNhbGVuZGFyLlxuXG5Zb3VyIGRldmljZSB3aWxsIGF1dG9tYXRpY2FsbHkgcmVtaW5kIHlvdSBi
ZWZvcmUgd2UgZ28gbGl2ZS5cblxuTW9zdCBwZW9wbGUgbWlzcyBsaXZlIHRyYWluaW5ncyBzaW1w
bHkgYmVjYXVzZSB0aGV5IGZvcmdldC5cblxuRG9u4oCZdCBiZSB0aGF0IHBlcnNvbi5cblxuSm9p
biBmcm9tIFBDXCwgTWFjXCwgaVBhZFwsIG9yIEFuZHJvaWQ6XG5odHRwczovL3pvb20udXMvdy85
MjI4NzMyNDQ5Mz90az0tSjc2TzRoSVFmRmlXR2IweDBYcEpWeWpCWXk5dlh1VHBDZ0pVSHNXR0ow
LkRRa0FBQUFWZk1EUlRSWkROVVExU3paTU1WRmxNbGhPYnkxRlkxWlRiVXBuQUFBQUFBQUFBQUFB
QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQSZ1dWlkPVdOXzdPV2tYN0J4VHd1S0VhRXV2
dWxZeEFcblxuUGhvbmUgb25lLXRhcDpcbisxMzQ2MjQ4Nzc5OVwsXCw5MjI4NzMyNDQ5MyMgVVMg
KEhvdXN0b24pXG4rMTM2MDIwOTU2MjNcLFwsOTIyODczMjQ0OTMjIFVTXG5cbkpvaW4gdmlhIGF1
ZGlvOlxuKzEgMzQ2IDI0OCA3Nzk5IFVTIChIb3VzdG9uKVxuKzEgMzYwIDIwOSA1NjIzIFVTXG4r
MSAzODYgMzQ3IDUwNTMgVVNcbisxIDUwNyA0NzMgNDg0NyBVU1xuKzEgNTY0IDIxNyAyMDAwIFVT
XG4rMSA2NDYgOTMxIDM4NjAgVVNcbisxIDY2OSA0NDQgOTE3MSBVU1xuKzEgNjY5IDkwMCA2ODMz
IFVTIChTYW4gSm9zZSlcbisxIDY4OSAyNzggMTAwMCBVU1xuKzEgNzE5IDM1OSA0NTgwIFVTXG4r
MSA5MjkgMjA1IDYwOTkgVVMgKE5ldyBZb3JrKVxuKzEgMjUzIDIwNSAwNDY4IFVTXG4rMSAyNTMg
MjE1IDg3ODIgVVMgKFRhY29tYSlcbisxIDMwMSA3MTUgODU5MiBVUyAoV2FzaGluZ3RvbiBEQylc
bisxIDMwNSAyMjQgMTk2OCBVU1xuKzEgMzA5IDIwNSAzMzI1IFVTXG4rMSAzMTIgNjI2IDY3OTkg
VVMgKENoaWNhZ28pXG5XZWJpbmFyIElEOiA5MjIgODczMiA0NDkzXG5JbnRlcm5hdGlvbmFsIG51
bWJlcnMgYXZhaWxhYmxlOiBodHRwczovL3pvb20udXMvdS9hYzloRW1jVE1UXG5cblxuDQpMT0NB
VElPTjpodHRwczovL3pvb20udXMvdy85MjI4NzMyNDQ5Mz90az0tSjc2TzRoSVFmRmlXR2IweDBY
cEpWeWpCWXk5dlh1VHBDZ0pVSHNXR0owLkRRa0FBQUFWZk1EUlRSWkROVVExU3paTU1WRmxNbGhP
YnkxRlkxWlRiVXBuQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQSZ1
dWlkPVdOXzdPV2tYN0J4VHd1S0VhRXV2dWxZeEENClNFUVVFTkNFOjE3NzM0MjM5NjcNCk9SR0FO
SVpFUjtST0xFPVJFUS1QQVJUSUNJUEFOVDtDTj1ab29tIFdlYmluYXI6bm8tcmVwbHlAem9vbS51
cw0KQVRURU5ERUU7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7Q049RnJpZW5kOm1haWx0bzpsaW51eC13
cGFuQHZnZXIua2VybmVsLm9yZw0KQkVHSU46VkFMQVJNDQpUUklHR0VSOi1QVDEwTQ0KQUNUSU9O
OkRJU1BMQVkNCkRFU0NSSVBUSU9OOlJlbWluZGVyDQpFTkQ6VkFMQVJNDQpFTkQ6VkVWRU5UDQpF
TkQ6VkNBTEVOREFSDQo=
--9fa3a51fe5cb454559359c20d50dc79b73df15cec07d5aca7f0e5b772380--
