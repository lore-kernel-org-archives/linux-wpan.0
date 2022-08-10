Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4D7C19F2D
	for <linux-wpan@archiver.kernel.org>; Wed, 10 Aug 2022 01:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiHJBld (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 9 Aug 2022 21:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiHJBlA (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 9 Aug 2022 21:41:00 -0400
Received: from mail.desertmonitor.com (desertmonitor.com [51.159.188.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B479B61134
        for <linux-wpan@vger.kernel.org>; Tue,  9 Aug 2022 18:40:56 -0700 (PDT)
Received: from [192.168.178.21] (p4fc3d4b3.dip0.t-ipconnect.de [79.195.212.179])
        by mail.desertmonitor.com (Postfix) with ESMTPSA id DCFAA20D66;
        Wed, 10 Aug 2022 01:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=desertmonitor.com;
        s=mail; t=1660095655;
        bh=x/18ZM+m8dEeaXaaXoev3CqMdxZR7387JMwdinATIzE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RAFDnQ2/O2v7Gc2WoV80PB5Kz3TFzJPuT0bJpQ3NIAo5FGtk6KJes7UmZXzwlT0NC
         SS5m9OBFf9Vd+iTne14KDzv4NNsBJ702FImZN9xOHfO9rhKsAAserpgj6WcGjae7m/
         RRWqRYGrvApPFN/Xz3LWNT5OUFEy8eGpxOGSdEck5cjZJzTHq5odoRQqNzOxGI4bU5
         DfGr6E4sbZQy5OT//sH/779Es9LPg1jjfI1XWha6kxoibiy65VqlG5bIjlUmAL7RRU
         nmuYU8/0hi2M5Ij6n0CyeZ/PQJFzVL/ybuiMJ5uIFSTqfoH4wk8b+iis5HrUqCe3pS
         pwtMhzaJ6rmeA==
Message-ID: <f1dcf16f-938c-0768-4c88-754a0ea7c2d0@desertmonitor.com>
Date:   Wed, 10 Aug 2022 03:40:54 +0200
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
From:   Philipp Blum <info@desertmonitor.com>
In-Reply-To: <CAK-6q+gBUHaR5njKHJJnONW41duVafMA-6R8jKMtN=7M1mg6rA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

 > Which neighbor discovery are you talking about? Can you be more
 > specific here?

Sorry, I cannot, since I am not too familiar with the network stack.
 From my point of view, mostly as a user of the stack, I can't pass down 
IPv6-PDs from my router down to the RIOT RPL network.
I need some workarounds with radvd in order to distribute the PD.
There is a markdown file about it: 
https://github.com/RIOT-OS/RIOT/blob/master/pkg/nimble/README.ipv6-over-ble.md

People in the matrix chat pointed me towards the mailing list.

best regards
Philipp Blum

On 10.08.22 02:17, Alexander Aring wrote:
> Hi,
> 
> On Tue, Aug 9, 2022 at 4:24 PM Philipp Blum <info@desertmonitor.com> wrote:
>>
>> Hey,
>>
>> I am currently working on a demonstration for the W3C TPAC next month.
>> Just wanted to get an update on this topic, since RIOT uses it in IPv6
>> over BLE.
>>
> 
> Which neighbor discovery are you talking about? Can you be more
> specific here? I am not aware that any 6LoWPAN implementation uses any
> optimized in-kernel IPv6 neighbor discovery for any low power/lossy
> network, we are still using the default IPv6 one which should probably
> still work if the other side supports it. In 802.15.4 we tweaked it a
> little bit to support the short address into the address option as
> RFC4944 describes it [0] that autoconfiguration can use it.
> 
> I added linux-bluetooth in cc.
> 
> - Alex
> 
> [0] https://www.rfc-editor.org/rfc/rfc4944#section-8
> 
