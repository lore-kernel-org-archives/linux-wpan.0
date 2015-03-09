Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:39518 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754069AbbCIJgn (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 9 Mar 2015 05:36:43 -0400
Received: by wiwl15 with SMTP id l15so18438429wiw.4
        for <linux-wpan@vger.kernel.org>; Mon, 09 Mar 2015 02:36:42 -0700 (PDT)
Date: Mon, 9 Mar 2015 10:36:38 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC bluetooth-next 2/2] at86rf230: add support for dt or pdata
 extended addr
Message-ID: <20150309093637.GB711@omega>
References: <1425802643-5798-1-git-send-email-alex.aring@gmail.com>
 <1425802643-5798-3-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1425802643-5798-3-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mkl@pengutronix.de

Hi,

On Sun, Mar 08, 2015 at 09:17:23AM +0100, Alexander Aring wrote:
> This patch adds support for setting the extended address over devicetree
> or platform data.

I should also add some notes in:

Documentation/devicetree/bindings/net/ieee802154/at86rf230.txt

about the extended-addr definition or should I add some generic 802.15.4
specific file where I describe the common way to add an extended.


If yes where should it be placed. Something like:

Documentation/devicetree/bindings/net/ieee802154/general.txt


Or should I define it driver specific. When setting "extended-addr" via
the dt property "extended-addr" then because the driver doesn't support
the handling.

- Alex
