Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:35531 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932979AbbGHIgB (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 8 Jul 2015 04:36:01 -0400
Received: by labgy5 with SMTP id gy5so68084415lab.2
        for <linux-wpan@vger.kernel.org>; Wed, 08 Jul 2015 01:35:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPpUg6MEoqR7TMraFevYiH--GDzPyHfZMLn9vZXycWdjHef9sg@mail.gmail.com>
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
Date: Wed, 8 Jul 2015 10:35:59 +0200
Message-ID: <CAPpUg6MrWCCYxWbu3e=RB98iuCEJggRA_OSreNkbif2+v_WnHA@mail.gmail.com>
Subject: Re: ping6 doesn't use at86rf230 driver
From: Baptiste Clenet <bapclenet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org

Finally, I won't be able to use the spi driver spi-mt7621 since it is
not a spi core but a serial flash core ... so I'm able 32 Bytes at
once but not more.
The last solution is to use a gpio-drived spi. One is provided, I'm
able to create a device but I'm wondering how to connect the at86rf230
to the simulated spi?

Before, I declared the at86rf230 in my dts under the spi bus.

-- 
Baptiste
