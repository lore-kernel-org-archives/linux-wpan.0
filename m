Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38429 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbbGXNHq (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 24 Jul 2015 09:07:46 -0400
Received: by wibxm9 with SMTP id xm9so27299147wib.1
        for <linux-wpan@vger.kernel.org>; Fri, 24 Jul 2015 06:07:45 -0700 (PDT)
Date: Fri, 24 Jul 2015 15:07:48 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: What is SAM value? "ieee802154 phy0 wpan0: SAM value 0x3 not
 supported"
Message-ID: <20150724130747.GA6051@omega>
References: <CAPpUg6PNNipdf-kXvy9EOo6_8HtauGXMR0WAjXG_gY82DQEY_g@mail.gmail.com>
 <20150724083106.GA2655@omega>
 <CAPpUg6MGJ6Mevu3NGMf3RqKu7Hxphk7C+WiUwEnJzDa5x56JYg@mail.gmail.com>
 <CAPpUg6M8rOP5mDNmFwcz1-cp=MhDhW1Yw5d2+YPCTy4sY4yGoQ@mail.gmail.com>
 <20150724094804.GA6561@omega>
 <CAPpUg6PKMOBkfKWZjVaRKHHFGo+GXb3csewX+1OHg7CieyuVSw@mail.gmail.com>
 <20150724101842.GA7552@omega>
 <CAPpUg6P5SfTPVui=1SzLAk55O63ahH0bH8NHJ68WXPEzfwB=mg@mail.gmail.com>
 <20150724121331.GA7623@omega>
 <CAPpUg6O9weo-qwLUWqhUJc4e9ZMK2-6UKfSU4wvB7byXhELYOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPpUg6O9weo-qwLUWqhUJc4e9ZMK2-6UKfSU4wvB7byXhELYOA@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Baptiste Clenet <bapclenet@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Fri, Jul 24, 2015 at 02:53:52PM +0200, Baptiste Clenet wrote:
...
> 
> Yes if SAC = 1, SAM should be 0 I agree.
> 
> Is that somehow possible that I send ihpc of 7b39 (taken at the end of
> lowpan_header_compress) and I receive and iphc of 7bf9 (taken at the
> begginning of lowpan_header_decompress) every time??
>

So far I know that is not possible. I think you need to debug it, do you
have maybe some kind of monitor interface to see what on the air?

When this happens randomly I had sometimes some corrupted data when the
spi clock is too high, but I think you use the bitbang gpio spi driver
now, or? Then I think the spi clock isn't the issue.

- Alex
