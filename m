Return-Path: <SRS0=x0Kh=27=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB084C33CA2
	for <linux-wpan@archiver.kernel.org>; Fri, 10 Jan 2020 08:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00FF2077C
	for <linux-wpan@archiver.kernel.org>; Fri, 10 Jan 2020 08:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbgAJIy3 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 10 Jan 2020 03:54:29 -0500
Received: from proxima.lasnet.de ([78.47.171.185]:36572 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbgAJIy2 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 10 Jan 2020 03:54:28 -0500
Received: from localhost.localdomain (p200300E9D717BC79DCC6644A9C173405.dip0.t-ipconnect.de [IPv6:2003:e9:d717:bc79:dcc6:644a:9c17:3405])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 24845C068B;
        Fri, 10 Jan 2020 09:54:27 +0100 (CET)
Subject: Re: [PATCH rpld 0/6] Mixed bag of rpld patches
To:     Alexander Aring <alex.aring@gmail.com>
Cc:     linux-wpan@vger.kernel.org
References: <20190918195819.7492-1-stefan@datenfreihafen.org>
 <20200109223859.kfveuy6tmwtzc5mm@ryzen>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <a1493f2c-887e-7552-7d44-09ead5c6af79@datenfreihafen.org>
Date:   Fri, 10 Jan 2020 09:54:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200109223859.kfveuy6tmwtzc5mm@ryzen>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello.

On 09.01.20 23:38, Alexander Aring wrote:
> Hi Stefan,
> 
> On Wed, Sep 18, 2019 at 09:58:13PM +0200, Stefan Schmidt wrote:
>> Hello.
>>
>> This series does really not have any theme, besides me starting
>> to look into rpld and playing around with it.
>>
>> I had to fix meson for my lua detection and make sure the ifdef
>> for SCOPE_ID is honoured. After getting it all building locally
>> I added Travis support and submitted builds to Coverity.
>> Afterwards I did a quick run through the reports from address
>> sanitizer and coverity scan.
>>
>> Not sure if you would prefer review for rpld as patches here on
>> the list or as pull requests on github. Up to you.
>>
>> Stefan Schmidt (6):
>>    build: test various names for our lua dependency
>>    send: make sure we check on scope id usage
>>    ci: travis: initial setup for CI testing with Travis
>>    config : fix leaks on error paths
>>    socket: make sure we close our socket if setsockopt() fails
>>    send: ensure we free the buffer after sending the message
> 
> I tested the patch series and so far it still compiles on my machine.
> 
> Reviewed-by: Alexander Aring <alex.aring@gmail.com>
> 
> on all patches.

Thanks. I landed them in master now.

regards
Stefan Schmidt
