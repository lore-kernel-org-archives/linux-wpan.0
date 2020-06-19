Return-Path: <SRS0=wjBD=AA=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93823C433DF
	for <linux-wpan@archiver.kernel.org>; Fri, 19 Jun 2020 20:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75A90208B8
	for <linux-wpan@archiver.kernel.org>; Fri, 19 Jun 2020 20:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391795AbgFSUQM (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 19 Jun 2020 16:16:12 -0400
Received: from proxima.lasnet.de ([78.47.171.185]:39410 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391792AbgFSUQL (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 19 Jun 2020 16:16:11 -0400
Received: from PC192.168.2.50 (p200300e9d71c614fed812a542701ea41.dip0.t-ipconnect.de [IPv6:2003:e9:d71c:614f:ed81:2a54:2701:ea41])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id DF568C051A;
        Fri, 19 Jun 2020 22:16:06 +0200 (CEST)
Subject: Re: [PATCH 1/2] docs: net: ieee802154: change link to new project URL
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-wpan@vger.kernel.org,
        alex.aring@gmail.com
References: <20200616065814.816248-1-stefan@datenfreihafen.org>
 <c8631876-8aea-c56d-105e-6866c74964ce@datenfreihafen.org>
 <20200619.125640.2128434436244521418.davem@davemloft.net>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <61652142-66cc-5693-9195-fa1a4b2b199c@datenfreihafen.org>
Date:   Fri, 19 Jun 2020 22:16:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200619.125640.2128434436244521418.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello.

On 19.06.20 21:56, David Miller wrote:
> From: Stefan Schmidt <stefan@datenfreihafen.org>
> Date: Fri, 19 Jun 2020 09:14:22 +0200
> 
>> I see you marked both patches here as awaiting upstream in
>> patchwork. I am not really sure what to do best now. Am I supposed to
>> pick them up myself and send them in my usual ieee802154 pull request?
>>
>> Before you had been picking up docs and MAINTAINERS patches
>> directly. I am fine with either way. Just want to check what you
>> expect.
> 
> Please put it into a pull request, thank you.

Done now.

regards
Stefan Schmidt
