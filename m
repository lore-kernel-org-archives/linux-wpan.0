Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6549EC05027
	for <linux-wpan@archiver.kernel.org>; Fri, 10 Feb 2023 18:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbjBJS7a (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 10 Feb 2023 13:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbjBJS73 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 10 Feb 2023 13:59:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D5A7BFC3;
        Fri, 10 Feb 2023 10:59:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4329061E61;
        Fri, 10 Feb 2023 18:59:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C98BC433EF;
        Fri, 10 Feb 2023 18:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676055566;
        bh=gOSstwPFMMk9fE/cCHUBfXPLjlf9Zm0PlxvyC6moXGE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NzL5YoIT0umDhh2Q4Y3baEE6LQ+hx/4u67nRz7im6vJtZDP1fcjl+lGqEkXhDeAEA
         BQYMg9iA7zEVgRjwJJFZgcyLTdbo9Xh50nKeXvLsAwCjBHl6EQgbrhdk3BVNw4Taht
         oVdAc9eQDLqfMIhwuzMRdrwDIFPT3dq4A8MEnLTj5p0fstRJlUdJc+FNZ+os973o4T
         UG4DUyoso7vRHEYK4yJtyIinQ63IiX5zIiplwpwyWsJAOkvFfa/4ktUWOhF3lTjuzr
         6Qj3HcZBkAWjCiXc7X95IHijLOWo4g8E3hin9J8GCJ7+sMhW2oPIlV/ENrwzO67+0A
         RwOE3WS6z/dAQ==
Date:   Fri, 10 Feb 2023 10:59:25 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Guilhem Imberton <guilhem.imberton@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH wpan-next 1/6] ieee802154: Add support for user scanning
 requests
Message-ID: <20230210105925.26c54e15@kernel.org>
In-Reply-To: <20230210111843.0817d0d3@xps-13>
References: <20221129160046.538864-1-miquel.raynal@bootlin.com>
        <20221129160046.538864-2-miquel.raynal@bootlin.com>
        <20230203201923.6de5c692@kernel.org>
        <20230210111843.0817d0d3@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

On Fri, 10 Feb 2023 11:18:43 +0100 Miquel Raynal wrote:
> > > +	/* Monitors are not allowed to perform scans */
> > > +	if (wpan_dev->iftype == NL802154_IFTYPE_MONITOR)    
> > 
> > extack ?  
> 
> Thanks for pointing at it, I just did know about it. I did convert
> most of the printk's into extack strings. Shall I keep both or is fine
> to just keep the extack thing?
> 
> For now I've dropped the printk's, please tell me if this is wrong.

That's right - just the extack, we don't want duplicated prints.
