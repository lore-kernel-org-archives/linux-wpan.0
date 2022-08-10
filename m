Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA581C00140
	for <linux-wpan@archiver.kernel.org>; Wed, 10 Aug 2022 23:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiHJXMu (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 10 Aug 2022 19:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiHJXMt (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 10 Aug 2022 19:12:49 -0400
X-Greylist: delayed 474 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 10 Aug 2022 16:12:47 PDT
Received: from mail.desertmonitor.com (desertmonitor.com [51.159.188.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0245377554;
        Wed, 10 Aug 2022 16:12:46 -0700 (PDT)
Received: from [192.168.178.21] (p4fc3d4b3.dip0.t-ipconnect.de [79.195.212.179])
        by mail.desertmonitor.com (Postfix) with ESMTPSA id CF8E420D46;
        Wed, 10 Aug 2022 23:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=desertmonitor.com;
        s=mail; t=1660172690;
        bh=M2U5z5fnJyyIwRacQTKLPBMbtA0XtG8nkW3I5CzC4fs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mEjCYZ+U5TrCJog8GYttlppMmbt/uwiHydsKDvpyHkFme3pWmfn3lNGWot4ecaeqs
         AhLH6r0gC3lM3OODLM4qOaGef/+ysf+mHA10WmW3E9iXJ6YrP1d/54vLYf+IPz2Bk6
         lW73k/tjJKlhwLa9IDpHiIEQSa++B5B1HL7GmQniZJ2uRsS2eWHQ6mDXXAGpBWpKjs
         Cb2D/h2UUS+1xXaci9vKI5Kcr001YxMMdBAx7kgWCKrE+h3MDOKFEQA4A7JyIf5UiH
         9mp63VIQO45CldZyHbBZzrzIvD9SG6PGJkGJ7Tajd9IP7QcEgxgC9ZK3YgcX1SLn4w
         JfZKQnWciJmsg==
Message-ID: <1d51db1a-746c-db67-99ec-cfe5c5a43616@desertmonitor.com>
Date:   Thu, 11 Aug 2022 01:04:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: 6LoWPAN (IPv6 over BLE) neighbor discovery
Content-Language: en-US
To:     Alexander Aring <aahringo@redhat.com>
Cc:     linux-wpan - ML <linux-wpan@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org
References: <3a3904c4-1bf9-ef1b-3d03-b5c3e1e2f8c5@desertmonitor.com>
 <CAK-6q+gBUHaR5njKHJJnONW41duVafMA-6R8jKMtN=7M1mg6rA@mail.gmail.com>
 <f1dcf16f-938c-0768-4c88-754a0ea7c2d0@desertmonitor.com>
 <CAK-6q+hfJ=oUHx0t7ueaNxg8NVsQZ2oJZ9wzj1PoP1fhHwpMrg@mail.gmail.com>
From:   Philipp Blum <philipp-blum@desertmonitor.com>
In-Reply-To: <CAK-6q+hfJ=oUHx0t7ueaNxg8NVsQZ2oJZ9wzj1PoP1fhHwpMrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

sorry, just realized I used the info@ email ^^

 > What kind of workarounds? I am curious...

The radvd workaround to distribute a PD.
Ideally I would like it to be as plug & and play as possible.
Connecting the sensors to my router and passing down the PD 
automatically. At the end of the day, not everyone is a dev.

 > Okay, if you like you could also try [0] on bluetooth networks... I
 > never did it on bluetooth. Although I think it does not make any sense
 > because it makes only sense on a mesh network and so far I understand
 > this is the difference between bluetooth 4.x vs 5.x/upwards and
 > currently there is no mesh bluetooth 6lowpan support here (but mesh
 > bluetooth on link-layer is there). It's a star topology. I guess what
 > you could try out is ndisc-proxy setup which is mostly the same but no
 > routing involved and they share the same prefix.

Btw, I am on Bluetooth 4.2. I had a hard time to even find non audio 
only Bluetooth 5.x USB sticks. Yes, it's only star topology so far. Even 
though, from my understanding, you could theoretically run a RPL network 
behind it.
There are more powerful MCUs that would be able to act as a RPL root.
Even though it probably would be better to use the linux border router 
as root. Puts less pressure on the sensor nodes.
I am not familiar with ndisc-proxy. If you could point me to some 
resources, that would be very helpful. Going to take a look into it.
Sharing the same prefix would be fine for now, since I only run it in a 
star topology anyway.
RPL should be, from my understanding, also work on BLE. RIOT allows 
three concurrent connections for BLE, as I remember.

I don't really understand why rpld only works in a mesh network.
When it runs on 6LoWPAN, it should also run on BLE, or am I missing 
something?

best regards
Philipp
