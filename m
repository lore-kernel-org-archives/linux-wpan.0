Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E848C0015E
	for <linux-wpan@archiver.kernel.org>; Wed,  9 Aug 2023 21:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjHIVkZ (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 9 Aug 2023 17:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjHIVkY (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 9 Aug 2023 17:40:24 -0400
X-Greylist: delayed 2110 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Aug 2023 14:40:23 PDT
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D951BF7
        for <linux-wpan@vger.kernel.org>; Wed,  9 Aug 2023 14:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=DxxrfxJdW+x6vHwwv13H/HcSziuw1ToHD20ksvqM8rE=;
        t=1691617223; x=1692826823; b=RP0qIeM0+7mmrbsl+vMBVfrj5+GOW3QUPI5eL2IM6N6WVNH
        V/95eA5TsaULOu494TsOK9KFRyNxMoSK4tTa3997K+TtcuGNbuVEhirTBwQ/D009rzZM19rnkTKBd
        A6MRwjhBI8XqSCbvXscX0Hz9NlwlBnrgG1Hc4Ix0bICdDn78YLz7llPgV5MNsxhBh3S23r0JBek87
        b68sqH4mUANYGvGBj1cwLvSoEwAS+PhcmJhVpXOPnom1UtZwHoFBeM3wQ2ly4Y6bNthV8VPiy/qNQ
        thkqtDkZMAF+KI3uo+CbptOSbvtlSN/OlGKfx1ve61PGkLDaBAXXngkVaHV1y3QQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qTqMM-00F8EE-2i;
        Wed, 09 Aug 2023 23:04:51 +0200
Message-ID: <4e0b764736eafde134e52e7609c6ad351a5282ad.camel@sipsolutions.net>
Subject: Re: [PATCH net-next 05/10] genetlink: use attrs from struct
 genl_info
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc:     netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
        jiri@resnulli.us, Jason@zx2c4.com, alex.aring@gmail.com,
        stefan@datenfreihafen.org, miquel.raynal@bootlin.com,
        krzysztof.kozlowski@linaro.org, jmaloy@redhat.com,
        ying.xue@windriver.com, floridsleeves@gmail.com, leon@kernel.org,
        jacob.e.keller@intel.com, wireguard@lists.zx2c4.com,
        linux-wpan@vger.kernel.org, tipc-discussion@lists.sourceforge.net
Date:   Wed, 09 Aug 2023 23:04:47 +0200
In-Reply-To: <20230809182648.1816537-6-kuba@kernel.org>
References: <20230809182648.1816537-1-kuba@kernel.org>
         <20230809182648.1816537-6-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

On Wed, 2023-08-09 at 11:26 -0700, Jakub Kicinski wrote:
> Since dumps carry struct genl_info now, use the attrs pointer
> use the attr pointer from genl_info and remove the one in
> struct genl_dumpit_info.

Some parts of that commit message got duplicated.

Otherwise looks fine,
Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

johannes
