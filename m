Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9362EC4708D
	for <linux-wpan@archiver.kernel.org>; Thu,  8 Dec 2022 01:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiLHB0a (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 7 Dec 2022 20:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiLHB02 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 7 Dec 2022 20:26:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C4A8E5A6;
        Wed,  7 Dec 2022 17:26:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53C8B61D12;
        Thu,  8 Dec 2022 01:26:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80312C433C1;
        Thu,  8 Dec 2022 01:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670462786;
        bh=3fXYsPC1fbYDxd/xYtvZBAzrsT7/Cn2L6Zj543M6XNw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gQVV9BFTEublja4Mdd5S1G6dI8lymevct4r0swz1XmhkGJ7HALzwI5tkcl85qLiDu
         xxj2Kl14sxHHjwrEHKAj1ptSMsl6CQnato2NaQkPxCUqcXk9/MKH9TN2h6rznF4P5a
         9hpkjQUOGz5hkIvq66bWsihzODybmJAitfeUn+A+vfniA+NhxyHhYp8gEcpMuU5pKg
         el+HP47T+OUA4ubSp2DGnzak64IFXFT1VBrEomYtWJ46tYrb6MdlgQ9wX3fhuLvEcb
         M4A3elCUKhK0kRqFVC8SdyVprI3Aw9xCljXW/iSMZ+Z3wW0NnezRseT313yIJgyZje
         m35PJuZVuhp2w==
Date:   Wed, 7 Dec 2022 17:26:25 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     davem@davemloft.net, linux-wpan@vger.kernel.org,
        alex.aring@gmail.com, netdev@vger.kernel.org
Subject: Re: pull-request: ieee802154 for net 2022-12-05
Message-ID: <20221207172625.7da96708@kernel.org>
In-Reply-To: <20221205122515.1720539-1-stefan@datenfreihafen.org>
References: <20221205122515.1720539-1-stefan@datenfreihafen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

On Mon,  5 Dec 2022 13:25:15 +0100 Stefan Schmidt wrote:
> Hello Dave, Jakub.
> 
> An update from ieee802154 for your *net* tree:
> 
> Three small fixes this time around.
> 
> Ziyang Xuan fixed an error code for a timeout during initialization of the
> cc2520 driver.
> Hauke Mehrtens fixed a crash in the ca8210 driver SPI communication due
> uninitialized SPI structures.
> Wei Yongjun added INIT_LIST_HEAD ieee802154_if_add() to avoid a potential
> null pointer dereference.

Sorry for the lateness, we are backed up since the weekend :(

I believe this is now in net:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=92439a859000c6f4c74160a3c08c1a519e3ca125

But the bot has not replied?
