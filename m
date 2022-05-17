Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D8EC433EF
	for <linux-wpan@archiver.kernel.org>; Tue, 17 May 2022 17:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiEQRcH (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 17 May 2022 13:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiEQRcH (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 17 May 2022 13:32:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8100438D91;
        Tue, 17 May 2022 10:32:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B384B81B2F;
        Tue, 17 May 2022 17:32:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE9EC385B8;
        Tue, 17 May 2022 17:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652808723;
        bh=NuGBigtyGKPXWM/MaUlUZBG/HmD7xPOta8lEUkmex90=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qVBFvUazhsMIfj1pq7ETdVEoefWaS76SV63TUTf1coelXoWWkpalWhLKM29j2Fzoe
         vGRMEQ2619Ac8qIs1iRMUY/y2jyTYP7dKO7wEWZcMiswmUGRQbxhBa2ovTiBY9BadF
         imlibOD7C5l9QrXcmsk7FwU8mDo17RyswZHX3woicUYa0RPPOBlZO8yKUjwswPpZd1
         rOpVKpgAVcixZVnuIX7SlJUNmPBExMnue8iblSy201Ixn4zAnk6gWIomXpGof0RaFc
         g6Lh/QKQHnj8JjlnnLb2zv1dMjfXcPqSYlnUI/Xu+/4mqfC0wrsYImiVfEH93RGpT/
         yJ+cX/Tp0I5CQ==
Date:   Tue, 17 May 2022 10:32:02 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
        pabeni@redhat.com, johannes@sipsolutions.net, alex.aring@gmail.com,
        stefan@datenfreihafen.org, mareklindner@neomailbox.ch,
        sw@simonwunderlich.de, a@unstable.cc, sven@narfation.org,
        linux-wireless@vger.kernel.org, linux-wpan@vger.kernel.org
Subject: Re: [PATCH net-next] net: ifdefy the wireless pointers in struct
 net_device
Message-ID: <20220517103202.6613c5ef@kernel.org>
In-Reply-To: <87zgjgwza1.fsf@kernel.org>
References: <20220516215638.1787257-1-kuba@kernel.org>
        <87zgjgwza1.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

On Tue, 17 May 2022 07:36:54 +0300 Kalle Valo wrote:
> > +void cfg80211_unregister_netdevice(struct net_device *dev)
> > +{
> > +	cfg80211_unregister_wdev(dev->ieee80211_ptr);
> > +}
> > +EXPORT_SYMBOL(cfg80211_unregister_netdevice);  
> 
> Why moving this to a proper function? Just curious, I couldn't figure it
> out.

Sorry, I went too far with the "explain what not why".
The header is included in places which get built without 
WIRELESS while the C source is not.
