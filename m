Return-Path: <SRS0=Bt4R=2M=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C949EC2D0C8
	for <linux-wpan@archiver.kernel.org>; Sun, 22 Dec 2019 22:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D1E6205C9
	for <linux-wpan@archiver.kernel.org>; Sun, 22 Dec 2019 22:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfLVWM3 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 22 Dec 2019 17:12:29 -0500
Received: from proxima.lasnet.de ([78.47.171.185]:54238 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfLVWM3 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 22 Dec 2019 17:12:29 -0500
X-Greylist: delayed 317 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Dec 2019 17:12:28 EST
Received: from PC192.168.2.50 (p200300E9D73E1E02041365448C97F985.dip0.t-ipconnect.de [IPv6:2003:e9:d73e:1e02:413:6544:8c97:f985])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id DCD5CC03CA;
        Sun, 22 Dec 2019 23:07:10 +0100 (CET)
Subject: Re: [PATCH rpld 0/6] Mixed bag of rpld patches
To:     Alexander Aring <alex.aring@gmail.com>
Cc:     linux-wpan - ML <linux-wpan@vger.kernel.org>
References: <20190918195819.7492-1-stefan@datenfreihafen.org>
 <CAB_54W5g137YQJRoVUrUF1ELoP_s1SWhocQ2sPLni6moHc4Tdw@mail.gmail.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <50906bc4-c27b-0f3d-352e-e1b3fd5613b9@datenfreihafen.org>
Date:   Sun, 22 Dec 2019 23:07:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAB_54W5g137YQJRoVUrUF1ELoP_s1SWhocQ2sPLni6moHc4Tdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello.

On 21.12.19 00:06, Alexander Aring wrote:
> Hi Stefan,
> 
> On Wed, 18 Sep 2019 at 15:58, Stefan Schmidt <stefan@datenfreihafen.org> wrote:
>>
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
> 
> I can't deal with the github gui! I click always the wrong buttons
> there. Thanks for setting up this travis support, does it work like
> wpan-tools to push it into branch "coverity_scan"?

Yes

> I would like to review patches via mail, what do you prefer? What is
> the procedure when somebody submits pull requests on github then,
> somebody of us send it via mail? Sounds more work... Can we do both as
> "whatever you like"? Can github somehow send pull request via github
> to this mailinglist? Would be nice to have something to connect the
> whole github thing to a mailinglist and you can control it with that
> as well... at least the commenting system but I think this isn't
> possible and the new kids wants all pull request via github gui. We
> didn't answered this question for wpan-tools as well and I once
> clicked the "merge" button (actually not by accident).

I do not mind any of the two methods. Getting Github and mailing lists 
working together is to big of a task on its own for such a small project 
to tackle in my opinion.

Given the low volumes of patches we are seeing on wpan-tools and maybe 
also rpld I would not mind if we say that we accept both ways. Mailing 
patches as well as pull requests. That would ease the contributions for 
some people I hope. And while it puts a bit more burden on us it should 
not be to hard given the low volume.

> 
> Also how we do that with signed off by thing? I can still fix it
> somehow what I did there...

Signed off by makes only sense if we have a document descriping what we 
mean by it. If we want it and use the one from the kernel we need to 
communicate this clearly. If not, the sign offs are off no use.

regards
Stefan Schmidt
