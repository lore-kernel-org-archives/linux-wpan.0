Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:53423 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754438AbeGII27 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 9 Jul 2018 04:28:59 -0400
Subject: Re: [PATCH 0/3] Misc fixes for problems found by checkpatch
References: <20180706081212.4776-1-stefan@datenfreihafen.org>
 <20180707160320.r2r6regfgrqnqcq4@x220t>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <812dc71e-82ce-8695-1723-fcb1bcc7a7c2@datenfreihafen.org>
Date: Mon, 9 Jul 2018 10:28:56 +0200
MIME-Version: 1.0
In-Reply-To: <20180707160320.r2r6regfgrqnqcq4@x220t>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aring@mojatatu.com>
Cc: linux-wpan@vger.kernel.org

Hello Alex.

On 07.07.2018 18:03, Alexander Aring wrote:
> Hi,
> 
> On Fri, Jul 06, 2018 at 10:12:09AM +0200, Stefan Schmidt wrote:
>> Hello.
>>
>> I just relasied these three patches from an earlier batch have never been
>> applied. (Thanks patchwork for allowing me to stay on top of things).
>>
>> Alex, I think the reason I did not apply them was that I waited for ACK's on
>> them.
>>
> 
> I have no problem with them...

Good, all three applied and pushed now.

> 
> btw: you know we don't use the energy detection callback at all _yet_?

I know, something we need to fix at some point. :-)

regards
Stefan Schmidt
