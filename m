Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:54254 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753162AbbGXOvS (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 24 Jul 2015 10:51:18 -0400
Subject: Re: What is SAM value? "ieee802154 phy0 wpan0: SAM value 0x3 not
 supported"
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
 <CAPpUg6NouBNDqfsZGYN9h-iuM8TSQD5+NdiqT-1_=1SzS8cacw@mail.gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55B250E2.7020906@osg.samsung.com>
Date: Fri, 24 Jul 2015 16:51:14 +0200
MIME-Version: 1.0
In-Reply-To: <CAPpUg6NouBNDqfsZGYN9h-iuM8TSQD5+NdiqT-1_=1SzS8cacw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Baptiste Clenet <bapclenet@gmail.com>, Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hello.

On 24/07/15 16:45, Baptiste Clenet wrote:
> 2015-07-24 15:07 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
>> On Fri, Jul 24, 2015 at 02:53:52PM +0200, Baptiste Clenet wrote:
>> ...
>>> Yes if SAC = 1, SAM should be 0 I agree.
>>>
>>> Is that somehow possible that I send ihpc of 7b39 (taken at the end of
>>> lowpan_header_compress) and I receive and iphc of 7bf9 (taken at the
>>> begginning of lowpan_header_decompress) every time??
>>>
>> So far I know that is not possible. I think you need to debug it, do you
>> have maybe some kind of monitor interface to see what on the air?
>>
> Here is what tcpdump gives me when I receive a message:
>
> 13:15:40.253868   P ethertype Unknown (0x00f6), length 82:
>          0x0000:  41c8 13ef beff ff56 7863 ed54 89a7 cffb  A  ......Vxc.T....
>          0x0010:  f93a 0201 ff34 1234 8700 a5ee 0000 0000   .:...4.4........
>          0x0020:  fe80 0000 0000 0000 1234 1234 1234 1234  .........4.4.4.4
>          0x0030:  0102 cfa7 8954 ede3 7856 0000 0000 0000  .....T..xV......
>          0x0040:  05c7
>
> There is neither 7b39 or  7bf9.
> Can't use tshark on openwrt.

That makes it harder as neccassary for debugging. Either try to use 
something like netcat to bring the stream to you host and look at it 
with wireshark or save it as pcap file, transfer it to your host and 
look at it with wireshark.

Doing it like above is really error prone. Why would you make your life 
harder as you should? :)

>
> Btw, why can't I add  lowpan0 on top of monitor0?
> root@OpenWrt:/# ip link add link monitor0 name lowpan0 type lowpan
> RTNETLINK answers: Invalid argument

Hmm, why would you want to do that? A monitor interface should give you 
all the information you need during sniffing. For what do you want to 
add a lowpan interface on top?

regards
Stefan Schmidt
