Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95769C00144
	for <linux-wpan@archiver.kernel.org>; Mon,  1 Aug 2022 23:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbiHAXbD (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 1 Aug 2022 19:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbiHAXbC (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 1 Aug 2022 19:31:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D402DE09C
        for <linux-wpan@vger.kernel.org>; Mon,  1 Aug 2022 16:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659396660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D/o96HbFGNX6+MOsG5cYu9h/be/lm/VS6F8MTBb4YvM=;
        b=bjnCe0ltHS3uqt1XOg8Cm+VCUf2938DDj2lZ47wWB6pbTlf6tYRdJdl2IAEzEXYsdHbNyx
        NXAEakGbX4DRBsFpdhV3N0K93rMFp+3TZrncwsHo18kwdCH1/4Z8QSCyPGddPfmrCgkgAt
        Ri9N1cw2lMgjJ0K+KA4TaxaodhccEts=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-2AaJPAsxOsmRYZDO0E9Z-Q-1; Mon, 01 Aug 2022 19:30:59 -0400
X-MC-Unique: 2AaJPAsxOsmRYZDO0E9Z-Q-1
Received: by mail-qt1-f198.google.com with SMTP id q21-20020ac84115000000b0031bf60d9b35so7947338qtl.4
        for <linux-wpan@vger.kernel.org>; Mon, 01 Aug 2022 16:30:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=D/o96HbFGNX6+MOsG5cYu9h/be/lm/VS6F8MTBb4YvM=;
        b=K5AyxL9oebJtDA0WM1X0bXeWpAG1DETc8yl1J++s85RB9tu2rFRpGem+B1lykdggxH
         RqknpPc1G4yOimJGccTMhRD7Z9CP8fyPCmeXeC9nJkuK4HtMa2Sxncs943ytcX0xQkjt
         JY9ustJu4tNwvZFs7n6ex6ZtYE4pmrs0ZqxGHRr6yr4RPYB87HE+QEYHtlX0PG8XgLdK
         GzMm/qgrvjd1SoL3wgW5pWu7NxAq4vCK49vnMl9szmOZjdizZB2w5yExTdebVCysckvu
         mkcNj5o5MaDtdLhv/w7ZLfGz2Rwueub/gdHxP0EfvqAqMpLT8SxgJn3A2On3V5Q3qO4B
         mxWA==
X-Gm-Message-State: AJIora8Ar+OinY5yGWKX+idUH33X442oup5cuJiS1WjeECdeJCOKGumq
        ElSr3Xp3J07piTzsOO0q0g8F1BWLjKU8WvlruIhpJSmPeBjg/hcUBpHRT/RMr09eLvMoLFWj0z0
        DLxsAZ7LhXwKID8kn2FdRgwfG/cS5OnYV5uc4ig==
X-Received: by 2002:ac8:6bc3:0:b0:31e:dc36:6cf8 with SMTP id b3-20020ac86bc3000000b0031edc366cf8mr16516664qtt.470.1659396659565;
        Mon, 01 Aug 2022 16:30:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vxdf+8dMV0XBdCQfj26A9dSfvIKieKLr+Jkfyp/gNde/lDI+stUnILGHADMCm3Ub9ql1i7N9T1KMCiYH+WiJI=
X-Received: by 2002:ac8:6bc3:0:b0:31e:dc36:6cf8 with SMTP id
 b3-20020ac86bc3000000b0031edc366cf8mr16516651qtt.470.1659396659407; Mon, 01
 Aug 2022 16:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220701143434.1267864-1-miquel.raynal@bootlin.com> <20220701143434.1267864-5-miquel.raynal@bootlin.com>
In-Reply-To: <20220701143434.1267864-5-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 1 Aug 2022 19:30:48 -0400
Message-ID: <CAK-6q+iKEQBJOjYU+eQcgXF934L_rrzk8JQVaHssx8WJu=CXAg@mail.gmail.com>
Subject: Re: [PATCH wpan-tools 4/7] iwpan: Remove duplicated SECTION
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Fri, Jul 1, 2022 at 10:39 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> From: David Girault <david.girault@qorvo.com>
>
> This section has been duplicated, drop one.
>
> Signed-off-by: David Girault <david.girault@qorvo.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Patch 1, 2, 3 and 4 seems to be fine. So far I know we don't do
Signed-off-by on wpan-tools but it doesn't harm it is there as Stefan
would say "there is no description what to sign for".

Stefan can you take care of this I know that there is a automated ci
stuff going on which you setup (thanks again for doing it) is it just
easy as commit it to the branch "coverity_scan" and if everything is
fine it gets automatically into master (just to confirm the process
here again)?

Thanks.

- Alex

