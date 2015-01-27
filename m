Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:51457 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932593AbbA0MuS (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 27 Jan 2015 07:50:18 -0500
Received: by mail-we0-f182.google.com with SMTP id l61so14654818wev.13
        for <linux-wpan@vger.kernel.org>; Tue, 27 Jan 2015 04:50:17 -0800 (PST)
Message-ID: <54C78987.7020908@6wind.com>
Date: Tue, 27 Jan 2015 13:50:15 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Reply-To: nicolas.dichtel@6wind.com
MIME-Version: 1.0
Subject: Re: [PATCH net 1/2] caif: remove wrong dev_net_set() call
References: <1422307694-10079-1-git-send-email-nicolas.dichtel@6wind.com>	<1422307694-10079-2-git-send-email-nicolas.dichtel@6wind.com>	<54C777D0.6090608@6wind.com> <874mrcwg3q.fsf@nemi.mork.no>
In-Reply-To: <874mrcwg3q.fsf@nemi.mork.no>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: =?UTF-8?B?QmrDuHJuIE1vcms=?= <bjorn@mork.no>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dmitry.tarnyagin@lockless.no, arvid.brodin@alten.se, alex.aring@gmail.com, linux-wpan@vger.kernel.org, =?UTF-8?B?U2p1ciBCcsOm?= =?UTF-8?B?bmRlbGFuZA==?= <sjur.brandeland@stericsson.com>, Dmitry Tarnyagin <abi.dmitryt@gmail.com>

Le 27/01/2015 13:41, Bjørn Mork a écrit :
> Nicolas Dichtel <nicolas.dichtel@6wind.com> writes:
>
>>> CC: Sjur Brændeland <sjur.brandeland@stericsson.com>
>>> CC: Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>
>>
>> I got a "Delivery Status Notification (Failure)" for Dmitry Tarnyagin
>> (I took the email address from the MAINTAINERS file):
>>
>>    Delivery to the following recipient failed permanently:
>>
>>         dmitry.tarnyagin@lockless.no
>>
>>    Technical details of permanent failure:
>>    Google tried to deliver your message, but it was rejected by the server for
>>    the recipient domain lockless.no by mail.lockless.no. [46.29.221.38].
>>
>>    The error that the other server returned was:
>>    550 5.1.1 <dmitry.tarnyagin@lockless.no>: Recipient address rejected: User
>>    unknown in virtual mailbox table
>>
>> Any suggestions?
>
>
> He used a gmail address in commit dd9dfb9f95e2 ("cfg80211: merge in
> beacon ies of hidden bss.").  Probably by accident, but worth trying
> anyway...
Ok, I will wait a bit before trying this address.

>
> I guess the stericsson.com addresses could be failing silently now? Ref
> http://stericsson.com/ . Or are they still routed to the named recepients?
I got also a delivery failure for sjur.brandeland@stericsson.com


Thank you,
Nicolas
