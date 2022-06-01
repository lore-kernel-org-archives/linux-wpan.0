Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64151C43334
	for <linux-wpan@archiver.kernel.org>; Wed,  1 Jun 2022 21:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbiFAV4s (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 1 Jun 2022 17:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiFAV4s (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 1 Jun 2022 17:56:48 -0400
X-Greylist: delayed 5286 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Jun 2022 14:56:46 PDT
Received: from proxima.lasnet.de (proxima.lasnet.de [IPv6:2a01:4f8:121:31eb:3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069382196;
        Wed,  1 Jun 2022 14:56:45 -0700 (PDT)
Received: from [IPV6:2003:e9:d72e:f86c:6f28:ee17:a8de:98f4] (p200300e9d72ef86c6f28ee17a8de98f4.dip0.t-ipconnect.de [IPv6:2003:e9:d72e:f86c:6f28:ee17:a8de:98f4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 59256C00B1;
        Wed,  1 Jun 2022 23:56:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1654120603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w0vACGztXLP8kYmZBZQRwM+VFAVRxFsXsAtUzZ+tveQ=;
        b=TPPIhMX4KOJoL9P0eKmxDo07NajtBDLRM3qbFEK3Do/43taXaVyZxcDb5ue33sb7uGPY7M
        BtfNdkFJu/a699G1CHjjL3CTT1NPmJnnQ9+HPZtDdl3vQcf87NhbAFB5JUnQp29IuNeZMF
        zgORI5qUzYmLo/KmeDge5HCk47irovIetG47XKOGgP54W5mw5Vr7mC0mnmSl6c2tUA9S2b
        JwWnNWPUr1XpDiQzt4lSQWtc3LOtCQ+3ZMvnQEA0PdNDZsn5NJJbcBnsxsagxKZG41jo3J
        iifgeviURCGi/M7p5P54r3zTjTGrCZQpY52a9d85oSoQvqHtyRPWnqeeu4Va4A==
Message-ID: <3b5d28c4-1877-ba8f-dcb3-d5c3cbc06a1f@datenfreihafen.org>
Date:   Wed, 1 Jun 2022 23:56:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH bluetooth-next 0/3] net: 6lowpan: simplify lookup by nhc
 id
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Alexander Aring <aahringo@redhat.com>,
        Jukka Rissanen <jukka.rissanen@linux.intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>
References: <20220428030534.3220410-1-aahringo@redhat.com>
 <06164dbe-3c11-c627-0929-a399414c01bf@datenfreihafen.org>
 <CABBYNZKCoj+W1MygU4eZZxGVSrWuRfEWx-fLOXvV-vXXY72vmw@mail.gmail.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <CABBYNZKCoj+W1MygU4eZZxGVSrWuRfEWx-fLOXvV-vXXY72vmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello Luiz.

On 01.06.22 23:48, Luiz Augusto von Dentz wrote:
> Hi Stefan,
> 
> On Wed, Jun 1, 2022 at 2:37 PM Stefan Schmidt <stefan@datenfreihafen.org> wrote:
>>
>> Hello.
>>
>> On 28.04.22 05:05, Alexander Aring wrote:
>>> Hi,
>>>
>>> this patch series removes the rb data structure for looking up a nhc by
>>> nhc id. Instead we using the existing nexthdr lookup array by iterating
>>> over it and find the right nhc by nhc id. It's simply not worth it to
>>> use such complex handling for such small amount of nhc. As we only
>>> support nhc ids which fits into 1 byte and there are not two byte nhc
>>> ids values specified yet, we let the nhc layer only handle 1 byte values.
>>> If there is the need for 2 byte nhc values we can add support for it.
>>>
>>> - Alex
>>>
>>> Alexander Aring (3):
>>>     net: 6lowpan: remove const from scalars
>>>     net: 6lowpan: use array for find nhc id
>>>     net: 6lowpan: constify lowpan_nhc structures
>>
>> Marcel, Luiz, are you still picking up generic 6lowpan patches or only
>> the ones for bluetooth?
>>
>> These three have been around for over a month and acked by me and Jukka,
>> but I can't find them anywhere in bluetooth-next or Linus tree.
>>
>> If 6lowpan is of less concern for you I can route them through my
>> ieee80254 tree as well.
> 
> Up to you, I was not aware they normally were merged thru
> bluetooth-next but I would be fine merging those as well.

If you and Marcel don't mind I would like to switch this over to being 
merged through ieee802154. Mostly because 6lowpan is vital for the 15.4 
work we have.

With Jukka stepping down from co-maintaining this part (thanks a lot for 
your work!) this will most likely be reviewed by Alex and me anyway.

We still need to ensure that patches are hitting wpan as well as 
bluetooth mailing list, but the MAINTAINERS file handles this already.

Let me know if you are unhappy with the switch. If not I will start with 
merging these three as well as the MAINTAINERS update from Jukka.

regards
Stefan Schmidt
