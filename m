Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33004 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753613AbbFIDl6 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 8 Jun 2015 23:41:58 -0400
Received: by pablj1 with SMTP id lj1so1517787pab.0
        for <linux-wpan@vger.kernel.org>; Mon, 08 Jun 2015 20:41:57 -0700 (PDT)
Message-ID: <5576606B.8010908@gmail.com>
Date: Tue, 09 Jun 2015 09:11:31 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: Coverity issues in linux-wpan
References: <55759332.4070700@osg.samsung.com> <20150608170422.GA1038@omega> <5575F6A4.3090008@osg.samsung.com>
In-Reply-To: <5575F6A4.3090008@osg.samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>, Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi,

On 06/09/2015 01:40 AM, Stefan Schmidt wrote:

> Hello.
>
> On 08/06/15 19:04, Alexander Aring wrote:
>> On Mon, Jun 08, 2015 at 03:05:54PM +0200, Stefan Schmidt wrote:
>>> Hello.
>>>
>>> I gave the currently found coverity issues in the linux-wpan area a 
>>> look.
>>> The analyzing builds are not tracking bluetooth-next but go with 
>>> Linus tree
>>> and get updated from time to time.
>>>
>>> As I'm not sure if all people here have access to this (you should 
>>> request
>>> it, its useful) I will cite the reported issues here with some context.
>>>
>>>  From what I can see 5 issues have been detected. Two in mac802154 
>>> and three
>>> in our drivers (cc2520 and mrf24j40).
>>>
>>> mrf24j40 (CID: 1226982, 1226983)
>>> o Return value with error codes gets overridden before returning.
>>> o I have a patch for that which I will send right after this mail.
>>>
>>> cc2520 (CID: 1230469)
>>> o Unchecked return value.
>>> o Should we check here as we do in the other cases or not?
>>>
>>> 622 if (filt->pan_coord)
>>> CID 1230469 (#1 of 2): Unchecked return value (CHECKED_RETURN)
>>> <https://scan5.coverity.com:8443/defectInstanceId=22519459&fileInstanceId=73901097&mergedDefectId=1230469> 
>>>
>>> 623 cc2520_write_register(priv, CC2520_FRMFILT0, 0x02);
>>> 624 else
>>> CID 1230469 (#2 of 2): Unchecked return value (CHECKED_RETURN)10.
>>> check_return: Calling cc2520_write_register without checking return 
>>> value
>>> (as is done elsewhere 21 out of 24 times).
>>> 625 cc2520_write_register(priv, CC2520_FRMFILT0, 0x00);
>>>
>>> mac802154/iface.c (CID: 1268751)
>>> o WARN_ON clears the parameter so we can't check for it afterwards 
>>> to hit
>>> the error path
>>>
>>> 147 if (!local->open_count) {
>>> 148 res = drv_start(local);
>>> cond_const: Condition res, taking false branch. Now the value of res is
>>> equal to 0.
>>> 149 WARN_ON(res);
>>> const: At condition res, the value of res must be equal to
>>> 0.dead_error_condition: The condition res cannot be true.
>>> 150 if (res)
>>> CID 1268751 (#1 of 1): Logically dead code (DEADCODE)dead_error_line:
>>> Execution cannot reach this statement: goto err;.
>>> 151 goto err;
>>> 152        }
>>>
>> Simple remove the WARN_ON or do WARN_ON(1) here, I would remove it.
>>
>> I remember this section [0]. I leave the old beheavior which was not
>> like wireless code. Nevertheless I had some bad feeling when I saw this
>> and doing some code around. This behaviour was always there.
>>
>> Comparing with wireless code, see [2].
> OK, this makes more sense now. I send a patch removing it. That way it 
> works like we intend it.
>
>>> mac802154/rx.c (CID: 1260107)
>>> o Coverity thinks hdr.seq might be used unitiliazed in the pr_debug 
>>> from
>>> ieee802154_parse_frame_start (line 149)
>>> o Setting hdr.seq = 0; here would not hurt but I still wonder how 
>>> coverity
>>> comes to think that as we pull the first three byte of the header 
>>> before
>>> which include fc and seq.
>>>
>>> 199 struct ieee802154_sub_if_data *sdata;
>>> 1. var_decl: Declaring variable hdr without initializer.
>>> 200 struct ieee802154_hdr hdr;
>>> 201
>>> CID 1260107 (#1 of 1): Uninitialized scalar variable (UNINIT)2.
>>> uninit_use_in_call: Using uninitialized value hdr.seq when calling
>>> ieee802154_parse_frame_start.
>>> <https://scan5.coverity.com:8443/eventId=22526690-1&modelId=22526690-0&fileInstanceId=73892728&filePath=%2Fnet%2Fmac802154%2Frx.c&fileStart=136&fileEnd=192> 
>>>
>>> 202 ret = ieee802154_parse_frame_start(skb, &hdr);
>>>
>> I think the hdr.seq should be filled by doing [1].
>>
> Agreed. That is also what I think where the seq should be filled from. 
> No idea why coverity gets this wrong. For now I consider this a false 
> positive and no real issue for us.
>
> That leaves only the cc2520 report open. Hopefully Varka has some 
> comment on this. We can either assume that ignoring the return in 
> these cases is fine or we add the error handling for them.

mhhh.. Its better to have the error handling at this place.

Please send the patch.

-- 
Varka Bhadram

