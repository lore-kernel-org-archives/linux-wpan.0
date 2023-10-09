Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC2DE95A96
	for <linux-wpan@archiver.kernel.org>; Mon,  9 Oct 2023 15:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376538AbjJIPYI (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 9 Oct 2023 11:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377636AbjJIPYB (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 9 Oct 2023 11:24:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4743AC;
        Mon,  9 Oct 2023 08:24:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC265C433C8;
        Mon,  9 Oct 2023 15:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696865040;
        bh=c+LVTQX5zg+keyPvguZV4kyGAzn9+JPENSKqzOGE7hE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2c633xjx7Mcpya6U253bbXQQlkd0hCs2abRXezhj03ehtaSpOdrL0DK0/SMcIVTKq
         4lGsx1SegTxLvvsIKGJ6fa1OFODDtv3fydxEIqeKRVFf1924btTe7bjkoG0lCaB0MI
         oNez1/TAVgZmjtDn0+XT6SCdizxojYZCgf8tEzIU=
Date:   Mon, 9 Oct 2023 17:23:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wpan@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Doug Brown <doug@schmorgal.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 06/10] staging: rtl8712: remove unused legacy ioctl
 handlers
Message-ID: <2023100953-ungraded-tutu-6128@gregkh>
References: <20231009141908.1767241-1-arnd@kernel.org>
 <20231009141908.1767241-6-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009141908.1767241-6-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

On Mon, Oct 09, 2023 at 04:19:04PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The .ndo_do_ioctl functions are never called, and can just be removed,
> especially since this is a staging driver.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/staging/rtl8712/os_intfs.c            |   1 -
>  drivers/staging/rtl8712/osdep_intf.h          |   2 -
>  drivers/staging/rtl8712/rtl871x_ioctl_linux.c | 124 ------------------
>  3 files changed, 127 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
