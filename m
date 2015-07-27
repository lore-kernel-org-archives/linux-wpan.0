Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38252 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428AbbG0QfH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Jul 2015 12:35:07 -0400
Received: by wibxm9 with SMTP id xm9so124865619wib.1
        for <linux-wpan@vger.kernel.org>; Mon, 27 Jul 2015 09:35:05 -0700 (PDT)
Date: Mon, 27 Jul 2015 18:35:13 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: What is SAM value? "ieee802154 phy0 wpan0: SAM value 0x3 not
 supported"
Message-ID: <20150727163509.GA794@omega>
References: <20150727102121.GC18090@omega>
 <CAPpUg6PnmbCitPQTL9YsJqPptnykRn_Nq-xbCYk1yegGwDToMQ@mail.gmail.com>
 <20150727103822.GD18090@omega>
 <CAPpUg6N0K-w_F0My0Wivi7W8MfYee-YSTr=8q2iDuFXFznQbtQ@mail.gmail.com>
 <20150727113054.GE18090@omega>
 <CAPpUg6OLEBfrMx6mA8ZptM-ohqhgbxS-V151hMP4O=61fQMTCw@mail.gmail.com>
 <20150727124220.GF18090@omega>
 <CAPpUg6MDArNF6Rpdv+XgOngFupru+RnEe5ujLgUuMejOmL3Y_w@mail.gmail.com>
 <CAPpUg6OZaGXCXi-K8vW01jtrYbD1ZSHdWCK+FSuAKr-WgQWrEg@mail.gmail.com>
 <CAPpUg6OxkeS4T1vkmdhcL4xYvCp7e-k+SkO2gvxxUOYV6t1qVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPpUg6OxkeS4T1vkmdhcL4xYvCp7e-k+SkO2gvxxUOYV6t1qVw@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Baptiste Clenet <bapclenet@gmail.com>
Cc: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org

Hi,

please don't send me tcpdumps from interfaces. Instrument the driver,
which is the lowest level which we have, for dumping the framebuffer at
before willing at xmit function and on receiving. Don't know exactly
the function inside at86rf230 driver, I said that previously.

If the transmitted frame and received frame is different, then I don't
know what's going on there and can't help you. It seems for me that your
spi functionality is broken.

The reason why you should not dump the wpan/lowpan interface is that the
data goes through the layers and I will detect if the raw data which
should be transmitted is correctly received. If not -> something weird
goes wrong. And again, I would not trust the wpan/lowpan dumps because
it will goes through layers which "could maybe" manipulate the raw data.

My consideration was look if the "raw" data is correct, because we don't
do anything which "raw" data. If you send "0xabcd" as frame to some node
and the receiving node receives "0xefgh" then something goes wrong with
the transceiver and I don't know why. So please capture the raw data
with the printk_hex_dump functionality and do a diff afterwards. On
transmit and receiving side.

- Alex
