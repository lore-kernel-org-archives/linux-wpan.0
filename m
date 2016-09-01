Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:36639 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933290AbcIAPF3 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 1 Sep 2016 11:05:29 -0400
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiBQcm9ibGVtcyBhYm91dCBoYW5kbGlu?=
 =?UTF-8?Q?g_duplicate_packets_when_frame_retry_is_enabled?=
References: <576133E7D398244EA0325FF7CE2A09E5CD55E15B@G08CNEXMBPEKD03.g08.fujitsu.local>
 <177f2368-0a94-079e-09ec-1093e62e5874@pengutronix.de>
 <576133E7D398244EA0325FF7CE2A09E5CD55E4B8@G08CNEXMBPEKD03.g08.fujitsu.local>
 <af477ae0-0dd1-cc21-86c2-40f99d86a14a@pengutronix.de>
 <576133E7D398244EA0325FF7CE2A09E5CD55FBCE@G08CNEXMBPEKD03.g08.fujitsu.local>
 <d9613918-2e12-e5ae-2232-5b011182fd61@pengutronix.de>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <fd4d3d2a-099e-82d0-ba22-95b18db3e940@pengutronix.de>
Date: Thu, 1 Sep 2016 17:04:53 +0200
MIME-Version: 1.0
In-Reply-To: <d9613918-2e12-e5ae-2232-5b011182fd61@pengutronix.de>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Xue, Wenqian" <xuewenqian@cn.fujitsu.com>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>


Hi,

On 08/20/2016 11:36 PM, Alexander Aring wrote:
> 
> Hi,
> 
> On 08/19/2016 03:10 PM, Xue, Wenqian wrote:
>> Hi, Alexander,
>>
>> Sorry for so late reply, as I have some other business at hand.
>>
>>> -----邮件原件-----
>>> 发件人: Alexander Aring [mailto:aar@pengutronix.de]
>>> 发送时间: 2016年8月13日 0:29
>>> 收件人: Xue, Wenqian/薛 文倩 <xuewenqian@cn.fujitsu.com>
>>> 抄送: linux-wpan@vger.kernel.org
>>> 主题: Re: 答复: Problems about handling duplicate packets when frame retry is
>>> enabled
>>>
>>>
> ...
>>>
>>> Your modification handles in duplicates in a form which is not acceptable. It will
>>> simple drop duplicates but how frame retries works is the following:
>>
>> If your meaning for my modification is that the result will be the same whether retry is enabled or not? Initially, my motivation is to prevent the received retry packet from being transmitted up to the wpan-ping level, then to avoid the error "Sequence number did not match".
>>
> 
> I looked deeper for that handling in 802.15.4-2011 (which is the version
> which is currently free available):
> 
> 5.1.6.6 Transmission scenarios
> 
> Your scenario is "Lost acknowledgment frame.", I don't see anything
> which let me accept your patch to drop multiple received frames with the
> same sequence number. The receiving node mac802154 stack is "recipient
> next layer".
> 
> Or did I miss something?
> 

I see currently 802.11 has some handling which you like to get in.
See [0]. But I don't see that such handling is described in 802.15.4 :-/

For me it's clean that it can be that duplicate frames can reach the
next layer and the next layer need to care about that. That's what
"Transmission scenario" - "Lost acknowledgment frame" shows me.

- Alex

[0] http://lxr.free-electrons.com/source/net/mac80211/rx.c#L1143
