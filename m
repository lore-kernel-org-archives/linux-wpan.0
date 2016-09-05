Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46020 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754985AbcIEIcm (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 5 Sep 2016 04:32:42 -0400
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiDnrZTlpI06IFByb2JsZW1zIGFib3V0?=
 =?UTF-8?Q?_handling_duplicate_packets_when_frame_retry_is_enabled?=
References: <576133E7D398244EA0325FF7CE2A09E5CD55E15B@G08CNEXMBPEKD03.g08.fujitsu.local>
 <177f2368-0a94-079e-09ec-1093e62e5874@pengutronix.de>
 <576133E7D398244EA0325FF7CE2A09E5CD55E4B8@G08CNEXMBPEKD03.g08.fujitsu.local>
 <af477ae0-0dd1-cc21-86c2-40f99d86a14a@pengutronix.de>
 <576133E7D398244EA0325FF7CE2A09E5CD55FBCE@G08CNEXMBPEKD03.g08.fujitsu.local>
 <d9613918-2e12-e5ae-2232-5b011182fd61@pengutronix.de>
 <fd4d3d2a-099e-82d0-ba22-95b18db3e940@pengutronix.de>
 <576133E7D398244EA0325FF7CE2A09E5CD56AAE4@G08CNEXMBPEKD02.g08.fujitsu.local>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <3b0f0380-9243-70b9-5305-3f35f41e27ef@pengutronix.de>
Date: Mon, 5 Sep 2016 10:32:39 +0200
MIME-Version: 1.0
In-Reply-To: <576133E7D398244EA0325FF7CE2A09E5CD56AAE4@G08CNEXMBPEKD02.g08.fujitsu.local>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Xue, Wenqian" <xuewenqian@cn.fujitsu.com>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>



On 09/04/2016 05:07 PM, Xue, Wenqian wrote:
> Hi, Alexander
> 
>> -----邮件原件-----
>> 发件人: Alexander Aring [mailto:aar@pengutronix.de]
>> 发送时间: 2016年9月1日 23:05
>> 收件人: Xue, Wenqian/薛 文倩 <xuewenqian@cn.fujitsu.com>
>> 抄送: linux-wpan@vger.kernel.org
>> 主题: Re: 答复: 答复: Problems about handling duplicate packets when frame
>> retry is enabled
>>
>>
>> Hi,
>>
>> On 08/20/2016 11:36 PM, Alexander Aring wrote:
>>>
>>> Hi,
>>>
>>> On 08/19/2016 03:10 PM, Xue, Wenqian wrote:
>>>> Hi, Alexander,
>>>>
>>>> Sorry for so late reply, as I have some other business at hand.
>>>>
>>>>> -----邮件原件-----
>>>>> 发件人: Alexander Aring [mailto:aar@pengutronix.de]
>>>>> 发送时间: 2016年8月13日 0:29
>>>>> 收件人: Xue, Wenqian/薛 文倩 <xuewenqian@cn.fujitsu.com>
>>>>> 抄送: linux-wpan@vger.kernel.org
>>>>> 主题: Re: 答复: Problems about handling duplicate packets when frame
>>>>> retry is enabled
>>>>>
>>>>>
>>> ...
>>>>>
>>>>> Your modification handles in duplicates in a form which is not
>>>>> acceptable. It will simple drop duplicates but how frame retries works is the
>> following:
>>>>
>>>> If your meaning for my modification is that the result will be the same
>> whether retry is enabled or not? Initially, my motivation is to prevent the
>> received retry packet from being transmitted up to the wpan-ping level, then to
>> avoid the error "Sequence number did not match".
>>>>
>>>
>>> I looked deeper for that handling in 802.15.4-2011 (which is the
>>> version which is currently free available):
>>>
>>> 5.1.6.6 Transmission scenarios
>>>
>>> Your scenario is "Lost acknowledgment frame.", I don't see anything
>>> which let me accept your patch to drop multiple received frames with
>>> the same sequence number. The receiving node mac802154 stack is
>>> "recipient next layer".
>>>
>>> Or did I miss something?
>>>
>>
>> I see currently 802.11 has some handling which you like to get in.
>> See [0]. But I don't see that such handling is described in 802.15.4 :-/
>>
>> For me it's clean that it can be that duplicate frames can reach the next layer
>> and the next layer need to care about that. That's what "Transmission scenario"
>> - "Lost acknowledgment frame" shows me.
>>
> I also checked the spec when I met the problem first, the spec really does not mention the handling for the duplicates. I thought it could be implemented in reality and should prevent the duplicates to the next layer. If according to your opinion " the next layer need to care about that ", the wpan-ping.c should care about the duplicates, right? Thank you!
> 

I think yes, some upper layers need to care about that or not. Here you
have like in "ping6" also a duplicate warning which indicates that you
received duplicates and _maybe_ there exists an issue in the lower
layers and I think you really should try to detect why you have an lost
acknowledgment frame.

- Alex
