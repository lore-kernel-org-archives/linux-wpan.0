Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F67EC6FD18
	for <linux-wpan@archiver.kernel.org>; Tue, 28 Mar 2023 22:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjC1WOY (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 28 Mar 2023 18:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjC1WOX (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 28 Mar 2023 18:14:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A801F2707;
        Tue, 28 Mar 2023 15:14:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4AD07B81EB0;
        Tue, 28 Mar 2023 22:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9016C433EF;
        Tue, 28 Mar 2023 22:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680041660;
        bh=hLuZ/50x0mSWQ8pTzYjfgPepDySpned8IVT9STsRDkU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LZ4NtsWItx54qVA1c2Pw7JchI9wcW1z5N013vmBvf7rPRG0cwiaf1JZUHm3JIkIJW
         pCoFY6g2Q9pQ3cfIq9odYaeTmCl0WjKiSN98hVruOlOLLQVFfc6P12YLo40+LWUqY5
         LKSoaO6ZIS8XkK9TKXT9UgMnryd+gLN7d7E7tw48degq8eiNynQXfTQLRcyaWGBRxM
         NFPv6HRYwZTISb5lGt6PMhtiACIY6ffNoZb9hC0ORTsMjx0JRBuaN46ZeT0Kb4rj0D
         /rY/qvZJcyVLf9Tyci5CK+g05gVHUSAMAdt7cAn3cbjFGDc1Mz7nqOqoY8TVBIFrRo
         q8LpzTlAf6ogA==
Date:   Tue, 28 Mar 2023 15:14:18 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     davem@davemloft.net, pabeni@redhat.com, linux-wpan@vger.kernel.org,
        alex.aring@gmail.com, miquel.raynal@bootlin.com,
        netdev@vger.kernel.org
Subject: Re: pull-request: ieee802154 for net 2023-03-24
Message-ID: <20230328151418.699f7026@kernel.org>
In-Reply-To: <605a1c16-0c03-a3be-9aec-12bb4d0113dc@datenfreihafen.org>
References: <20230324173931.1812694-1-stefan@datenfreihafen.org>
        <20230327193842.59631f11@kernel.org>
        <605a1c16-0c03-a3be-9aec-12bb4d0113dc@datenfreihafen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

On Tue, 28 Mar 2023 09:10:07 +0200 Stefan Schmidt wrote:
> Sorry for that. I did not update my pull request script when changing 
> the git tree URLs to our team tree. Updated now.
> 
> The tag is now on the tree above. You want me to send a new pull request 
> or do you take it from here?

Thanks, fresh PR would be better, I can't re-trigger the patchwork
checks on an existing one :(
