Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:33453 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168AbbGAIVl (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 1 Jul 2015 04:21:41 -0400
Received: by wgck11 with SMTP id k11so29908683wgc.0
        for <linux-wpan@vger.kernel.org>; Wed, 01 Jul 2015 01:21:40 -0700 (PDT)
Date: Wed, 1 Jul 2015 10:21:35 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: ping6 doesn't use at86rf230 driver
Message-ID: <20150701082130.GA1834@omega>
References: <CAPpUg6ODFfRpaM9EtL0YY4iHNbgOtgZ4QLVzGpSYkC-zRGY+7w@mail.gmail.com>
 <20150626080338.GB959@omega>
 <CAPpUg6PQZ8aYabugqr1jL=yfE1HmWinCzy1JN4LCv1QXbfw6dQ@mail.gmail.com>
 <CAPpUg6O61HyVEiTXD7r-14dVp-G3thy_YSG06PSUDooDEPHEFw@mail.gmail.com>
 <20150629080937.GA1674@omega>
 <55910C2F.3070601@gmail.com>
 <CAPpUg6Nb0TXj7Xm0WTv+T4K-3BV-VJjsQcCJabd3txg7JHv-pQ@mail.gmail.com>
 <CAPpUg6NUwAGo402HgJkwcDTyT3HPBAAnSEW7V63zUyv5PHSJ8A@mail.gmail.com>
 <20150629220929.GB1165@omega>
 <CAPpUg6N5SAY3fOio7zGnsOPkYytgx5gRgfULO5=6Tz+fcN-9PA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPpUg6N5SAY3fOio7zGnsOPkYytgx5gRgfULO5=6Tz+fcN-9PA@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Baptiste Clenet <bapclenet@gmail.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org

Hi,

On Tue, Jun 30, 2015 at 11:12:36AM +0200, Baptiste Clenet wrote:
....
> 
> root@OpenWrt:/# dmesg | grep at86rf230
> [   94.820000] at86rf230 spi32766.1: Detected at86rf212 chip version 3
> [   94.830000] at86rf230 spi32766.1: unexcept state change from 0x00
> to 0x08. Actual state: 0x00
> 
> It detects the chip but yes definitely, there is problem to read the state.
> Will check the pins
> 

if you have debugfs support and mounted it, then you could dump all
register settings by doing something similar like:

cat /sys/kernel/debug/regmap/spi1.0/registers

result would be some $REGISTER <-> $VALUE mapping.

Note:

One interface of the 802.15.4 phy should be up for this development method,
because the transceiver isn't in sleep mode then.

- Alex
