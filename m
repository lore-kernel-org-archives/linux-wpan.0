Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:35659 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbbGILTH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 9 Jul 2015 07:19:07 -0400
Received: by labgy5 with SMTP id gy5so91854191lab.2
        for <linux-wpan@vger.kernel.org>; Thu, 09 Jul 2015 04:19:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPpUg6MrWCCYxWbu3e=RB98iuCEJggRA_OSreNkbif2+v_WnHA@mail.gmail.com>
References: <CAPpUg6O6gJ=GTTqxDDY1C85mVSj-R6DSD+XaXwWZ8Zhs4VYT4g@mail.gmail.com>
	<CAPpUg6OiRu2XWb_xMXDVzuSLYP7=JeD1ULcksCh=WjprxxCbKA@mail.gmail.com>
	<20150701151653.GA969@omega>
	<CAPpUg6Obeifuy8eistOir7yjEkZOfbW8WEM8JTJ6v5LwY711EA@mail.gmail.com>
	<20150702161239.GA1258@omega>
	<CAPpUg6MxRFgcwyUfd7joz=7AxtbhUgCdfukthk7qzv5k2ADCCg@mail.gmail.com>
	<20150703154724.GA24800@omega>
	<CAPpUg6NSwRpHQX71jeHqLyvZayVonzBLiwQjh6_MQ+erEcTMxw@mail.gmail.com>
	<20150703173729.GA2651@omega>
	<CAPpUg6Pvt6-YQO6aKSC13=+12pbugCoZGCGTJaJV9JG88KHsuQ@mail.gmail.com>
	<20150704153629.GA12767@omega>
	<CAPpUg6MEoqR7TMraFevYiH--GDzPyHfZMLn9vZXycWdjHef9sg@mail.gmail.com>
	<CAPpUg6MrWCCYxWbu3e=RB98iuCEJggRA_OSreNkbif2+v_WnHA@mail.gmail.com>
Date: Thu, 9 Jul 2015 13:19:05 +0200
Message-ID: <CAPpUg6P8UKXP6dJ-yESR0ovobEms-EiUJBsqKKv0wSr0M6AUVg@mail.gmail.com>
Subject: Re: ping6 doesn't use at86rf230 driver
From: Baptiste Clenet <bapclenet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org

Update status; the at86rf230 works completely now! (just need to
receive a message to ensure that the IRQ works)

I'm coming back to my first question now:
Using
ping6 -I lowpan0 fe80::b120:cfb8:7913:a051

with
root@OpenWrt:/# ifconfig lowpan0
lowpan0   Link encap:UNSPEC  HWaddr
B3-20-CF-B8-79-13-A0-50-00-00-00-00-00-00-00-00
          inet6 addr: fe80::b120:cfb8:7913:a050/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1280  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

doesn't use the at86rf230 driver

Linux 4.1.0

-- 
Baptiste
