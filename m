Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E537C433DB
	for <linux-wpan@archiver.kernel.org>; Tue, 30 Mar 2021 07:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D76A61582
	for <linux-wpan@archiver.kernel.org>; Tue, 30 Mar 2021 07:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhC3HaU (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 30 Mar 2021 03:30:20 -0400
Received: from proxima.lasnet.de ([78.47.171.185]:35050 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhC3HaM (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 30 Mar 2021 03:30:12 -0400
Received: from [IPv6:2003:e9:d726:e14c:1577:8d47:675:6abb] (p200300e9d726e14c15778d4706756abb.dip0.t-ipconnect.de [IPv6:2003:e9:d726:e14c:1577:8d47:675:6abb])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id B870DC02DA;
        Tue, 30 Mar 2021 09:30:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1617089408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cLqUYyiLsjGYaqqZp5al/9Cvfk7vmvoI37PSRJmvFy0=;
        b=m1wcFh4EXOLED/c0o5LJJ5FCnUcqTGbzyUwa4rgEvz4axeM6MardPjHo4EChmeeSNesFPr
        n1CFpOisj9hQjx6BlsOQ/Q7q2Tr4UBYMJQXh0z5bRjtyD0ET4+gLi0oEZ/puz+1XGNMynS
        ZHiW06FroWBM4a1xo1aFc14bmHGJpLeeSEuxN7ROt4MPLDzr/Sny7rBQP6QNs8oIMbVt2X
        cs1THsEYzwilcztKm9WHAB4jJpBNGy9/HZ7IJUqElwFu3Yii0FQr1RgrCohyyoIwzDrIEe
        keN62iWkhXnKAw5AsLnopbjqMiqwSHoceXVI/nxQWqiGFrlgRoiRv8WNP/B14A==
Subject: Re: things not working - newbie questions
To:     Mark Butsch <Mark.Butsch@myfuelmaster.com>,
        "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>
References: <SN6PR01MB364865A6E7BF0E559808BD9587649@SN6PR01MB3648.prod.exchangelabs.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <a993264a-8bc5-586b-5dac-34d50adfe7b2@datenfreihafen.org>
Date:   Tue, 30 Mar 2021 09:30:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <SN6PR01MB364865A6E7BF0E559808BD9587649@SN6PR01MB3648.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello.

On 23.03.21 22:14, Mark Butsch wrote:
> Hello,
> 
> Sorry if this has all been asked before.
> 
> I am trying to setup a 6lowpan network using a Raspberry Pi 400 and Atmel REB233-XPRO modules (AT86RF233). I have 2 of each.
> 
> I have wired the radio modules to the Raspberry Pi GPIO connector.
> 
> If have created a device tree overlay that I think works when applied because I see this in the dmesg output:
> 
> [   36.388574] at86rf230 spi0.0: Detected at86rf233 chip version 2
> 
> I have installed 'wpan-tools' and 'lowpan-tools'

You will need wpan-tools only. lowpan tools is deprecated for a long 
time now.

> 
> I get what looks like good output when I run:
> 
> $ iwpan dev wpan0 info
> Interface wpan0
>          ifindex 4
>          wpan_dev 0x1
>          extended_addr 0xc62e26eced5de562
>          short_addr 0xffff
>          pan_id 0xffff
>          type node
>          max_frame_retries 3
>          min_be 3
>          max_be 5
>          max_csma_backoffs 4
>          lbt 0
>          ackreq_default 0
> 
> I tried to setup a 6lowpan network (based on things I googled) but pings didn't work, so I am starting over trying to confirm the lower level parts are working first.
> 
> I set the pan_id to 0xabba on both systems.
> 
> I set the short_addr to 0x0001 on one and 0x0002 on the other.
> 
> When I try using wpan-ping (from 0x0001), I get:
> 
> $ wpan-ping -a 0x0002 -c 5
> PING 0x0002 (PAN ID 0xabba) 5 data bytes
> Hit 500 ms packet timeout
> Hit 500 ms packet timeout
> Hit 500 ms packet timeout
> Hit 500 ms packet timeout
> Hit 500 ms packet timeout

Do you actually run wpan-ping in server mode on the other node? Without 
it there would be no reply. Its different from the normal ping utility.

> I used "ip link set wpan0 up" (on both systems) and the result is the same, but I can see packets in wireshark on wpan0.
> 
> A hardware person here suggested using a near field probe to see if we could detect any transmission. We didn't. So I don't know if the radios are actually transmitting.
> 
> Any suggestions on where to go next?

For wpan-ping you need to ahve the server on the other node as stated above.

For your 6lowpan ping6 problem I have not enough description of the 
actual problem to help you.

regards
Stefan Schmidt
