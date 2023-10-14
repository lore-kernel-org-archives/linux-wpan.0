Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6835ACDB465
	for <linux-wpan@archiver.kernel.org>; Sat, 14 Oct 2023 06:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjJNGmI (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 14 Oct 2023 02:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNGmH (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 14 Oct 2023 02:42:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E4B83;
        Fri, 13 Oct 2023 23:42:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7893DC433C8;
        Sat, 14 Oct 2023 06:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697265725;
        bh=Pvnp6ClDU4xAPFz+GWQJRLH4Q1XIrlzcHFNtXw92fUQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=IFrC+uuAlTszbKfHKFobiZGt35OWBZvGIonkyj/r68qF6fQ4z4aH3+ZHBwyT6DQKs
         ELO4kjrrSll4lLcK9w56nn+NB7JrCGdQvbIJANYfbesEssGtFyCZ+tdDXiRLEuPNJq
         NWwxEif8pM/z0It850p4If9P7PDrKK+caiQZm8Ke206qqfEU7zRXLr3O/dR9Rv3TjV
         4E2UvmNu6xmMx5QDGnwzGOQOVNAsLbl/6xTKRmXaPgBolYcIOLnZEWONO1c4eYjN+/
         1/nv6HMX+Fjtz2RfLiUGcLbZCxDtcsa6TkxLpQqA2KQc3slwOjmr8G4QkwkmDherTt
         49buWmwGgjxzw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 08/10] wifi: atmel: remove unused ioctl function
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231011140225.253106-8-arnd@kernel.org>
References: <20231011140225.253106-8-arnd@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wpan@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Rodolfo Zitellini <rwz@xhero.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169726572036.3637479.12619977038667266484.kvalo@kernel.org>
Date:   Sat, 14 Oct 2023 06:42:02 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> This function has no callers, and for the past 20 years, the request_firmware
> interface has been in place instead of the custom firmware loader.
> 
> Acked-by: Kalle Valo <kvalo@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

2 patches applied to wireless-next.git, thanks.

166ab7ca3418 wifi: atmel: remove unused ioctl function
f35ccb65bd18 wifi: hostap: remove unused ioctl function

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231011140225.253106-8-arnd@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

