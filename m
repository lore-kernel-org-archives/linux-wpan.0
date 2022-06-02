Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852C6C43334
	for <linux-wpan@archiver.kernel.org>; Thu,  2 Jun 2022 17:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237533AbiFBRib (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 2 Jun 2022 13:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbiFBRib (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 2 Jun 2022 13:38:31 -0400
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D2F11C0F;
        Thu,  2 Jun 2022 10:38:28 -0700 (PDT)
Received: from [IPV6:2003:e9:d738:31bf:d5a9:1442:9319:c966] (p200300e9d73831bfd5a914429319c966.dip0.t-ipconnect.de [IPv6:2003:e9:d738:31bf:d5a9:1442:9319:c966])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 56ABCC05A1;
        Thu,  2 Jun 2022 19:38:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1654191506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y8uGKYq3zLyS48gMXz1D+2XcOy5wkh53quO7bcbPfV0=;
        b=qz/Wci9t+F4t7jKWTfZLuPDxNJJ3FYSOpVV4euqx5NNdJbKTg0xUT4cg56SMMqSrs9EPK4
        GFS2Uu7Gzd4VjTPZvJCTK8vLa59af+fwy0c8KkNO07JJPcLWy5/78bPYQnmVxngymT/mt5
        7/m87pK2QWOTix18ab/wbxm8LwyYYpPQQxSW89/2Ct3PRyFtj0CTJnIQq5/Sor75JAttJS
        dyBXyEZ3iLn1wkufxJzqfPSik5By8TOm9BtqyhblBghGzGj//hgmYsh/AAV/YonfGf3/cx
        rM8bDCnh63FR+IAsVo37dp6l88W4tQLOaG3Nh90TRUZkq+SwLtvXoKpg2kssxg==
Message-ID: <0b31b950-ab72-251e-f085-9a86538d9a6f@datenfreihafen.org>
Date:   Thu, 2 Jun 2022 19:38:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH bluetooth-next 0/3] net: 6lowpan: simplify lookup by nhc
 id
Content-Language: en-US
To:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Alexander Aring <aahringo@redhat.com>,
        Jukka Rissanen <jukka.rissanen@linux.intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>
References: <20220428030534.3220410-1-aahringo@redhat.com>
 <06164dbe-3c11-c627-0929-a399414c01bf@datenfreihafen.org>
 <CABBYNZKCoj+W1MygU4eZZxGVSrWuRfEWx-fLOXvV-vXXY72vmw@mail.gmail.com>
 <3b5d28c4-1877-ba8f-dcb3-d5c3cbc06a1f@datenfreihafen.org>
 <CABBYNZK1uWjxmvJUBPaUdMvj8B-p=TtRKTUwQ0szCgLhh+7CcA@mail.gmail.com>
 <89A5D478-0611-4F20-B2BF-3CF3E3E82F9C@holtmann.org>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <89A5D478-0611-4F20-B2BF-3CF3E3E82F9C@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello Marcel

On 02.06.22 17:27, Marcel Holtmann wrote:
> Hi Stefan,
> 
>>>>>> this patch series removes the rb data structure for looking up a nhc by
>>>>>> nhc id. Instead we using the existing nexthdr lookup array by iterating
>>>>>> over it and find the right nhc by nhc id. It's simply not worth it to
>>>>>> use such complex handling for such small amount of nhc. As we only
>>>>>> support nhc ids which fits into 1 byte and there are not two byte nhc
>>>>>> ids values specified yet, we let the nhc layer only handle 1 byte values.
>>>>>> If there is the need for 2 byte nhc values we can add support for it.
>>>>>>
>>>>>> - Alex
>>>>>>
>>>>>> Alexander Aring (3):
>>>>>> net: 6lowpan: remove const from scalars
>>>>>> net: 6lowpan: use array for find nhc id
>>>>>> net: 6lowpan: constify lowpan_nhc structures
>>>>>
>>>>> Marcel, Luiz, are you still picking up generic 6lowpan patches or only
>>>>> the ones for bluetooth?
>>>>>
>>>>> These three have been around for over a month and acked by me and Jukka,
>>>>> but I can't find them anywhere in bluetooth-next or Linus tree.
>>>>>
>>>>> If 6lowpan is of less concern for you I can route them through my
>>>>> ieee80254 tree as well.
>>>>
>>>> Up to you, I was not aware they normally were merged thru
>>>> bluetooth-next but I would be fine merging those as well.
>>>
>>> If you and Marcel don't mind I would like to switch this over to being
>>> merged through ieee802154. Mostly because 6lowpan is vital for the 15.4
>>> work we have.
>>>
>>> With Jukka stepping down from co-maintaining this part (thanks a lot for
>>> your work!) this will most likely be reviewed by Alex and me anyway.
>>>
>>> We still need to ensure that patches are hitting wpan as well as
>>> bluetooth mailing list, but the MAINTAINERS file handles this already.
>>>
>>> Let me know if you are unhappy with the switch. If not I will start with
>>> merging these three as well as the MAINTAINERS update from Jukka.
>>
>> I have no problem with that.
> 
> go for it. Lets just keep the mailing list in MAINTAINERS file so we are aware of patches in this area.

Yup, that's the plan. Taking the pending patch in now.

regards
Stefan Schmidt
