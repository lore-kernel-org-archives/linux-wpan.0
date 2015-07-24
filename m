Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:32802 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbbGXOpM (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 24 Jul 2015 10:45:12 -0400
Received: by lbbyj8 with SMTP id yj8so16731921lbb.0
        for <linux-wpan@vger.kernel.org>; Fri, 24 Jul 2015 07:45:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150724130747.GA6051@omega>
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
	<20150724130747.GA6051@omega>
Date: Fri, 24 Jul 2015 16:45:10 +0200
Message-ID: <CAPpUg6NouBNDqfsZGYN9h-iuM8TSQD5+NdiqT-1_=1SzS8cacw@mail.gmail.com>
Subject: Re: What is SAM value? "ieee802154 phy0 wpan0: SAM value 0x3 not supported"
From: Baptiste Clenet <bapclenet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

2015-07-24 15:07 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
> On Fri, Jul 24, 2015 at 02:53:52PM +0200, Baptiste Clenet wrote:
> ...
>>
>> Yes if SAC = 1, SAM should be 0 I agree.
>>
>> Is that somehow possible that I send ihpc of 7b39 (taken at the end of
>> lowpan_header_compress) and I receive and iphc of 7bf9 (taken at the
>> begginning of lowpan_header_decompress) every time??
>>
>
> So far I know that is not possible. I think you need to debug it, do you
> have maybe some kind of monitor interface to see what on the air?
>
Here is what tcpdump gives me when I receive a message:

13:15:40.253868   P ethertype Unknown (0x00f6), length 82:
        0x0000:  41c8 13ef beff ff56 7863 ed54 89a7 cffb  A  ......Vxc.T....
        0x0010:  f93a 0201 ff34 1234 8700 a5ee 0000 0000   .:...4.4........
        0x0020:  fe80 0000 0000 0000 1234 1234 1234 1234  .........4.4.4.4
        0x0030:  0102 cfa7 8954 ede3 7856 0000 0000 0000  .....T..xV......
        0x0040:  05c7

There is neither 7b39 or  7bf9.
Can't use tshark on openwrt.

Btw, why can't I add  lowpan0 on top of monitor0?
root@OpenWrt:/# ip link add link monitor0 name lowpan0 type lowpan
RTNETLINK answers: Invalid argument



> When this happens randomly I had sometimes some corrupted data when the
> spi clock is too high, but I think you use the bitbang gpio spi driver
> now, or? Then I think the spi clock isn't the issue.
>
> - Alex



-- 
Baptiste
