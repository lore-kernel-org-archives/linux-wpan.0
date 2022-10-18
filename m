Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B13FC4332F
	for <linux-wpan@archiver.kernel.org>; Tue, 18 Oct 2022 20:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJRUyb (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 18 Oct 2022 16:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiJRUya (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 18 Oct 2022 16:54:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E03B631A
        for <linux-wpan@vger.kernel.org>; Tue, 18 Oct 2022 13:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666126468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hO1LFELXQEUpYNdXEw0Kt4gZtU698gtGrVoO0zJ7b2o=;
        b=fOjq6pAPc5M2mut1doNaAqbEClvS85ocZXYvrv1s0nP9OtAIwPqJX4gp2EEYYo4kPxm8kc
        XOKpGUoBSqUC8kNoRjzdszqh44rb8IPkqWRJSjAlZip+PV5AHIGU6IPGVbalKHxsIdU+8X
        dZ1uvoDwm+Wk5z8QtqJ4Hrmcgz0MJYE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-411-atQhL-zHPk2irEFFUp-6fg-1; Tue, 18 Oct 2022 16:54:27 -0400
X-MC-Unique: atQhL-zHPk2irEFFUp-6fg-1
Received: by mail-wm1-f70.google.com with SMTP id p42-20020a05600c1daa00b003c6ee394f0dso6736795wms.5
        for <linux-wpan@vger.kernel.org>; Tue, 18 Oct 2022 13:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hO1LFELXQEUpYNdXEw0Kt4gZtU698gtGrVoO0zJ7b2o=;
        b=o0oe0upvy44ISflNhlmOIzLPKqQ3vUGn2fJSGUBnHKno5UphNqaqVGsj6lbwbZm4z2
         D06f9KLvz1F1VU1vINHxmfCa+5mfj4bqv3NWOWAZXDKFOkMPT5ktNxuOUaJHsSci6G55
         VZ9Pmtyt7t6wJc5i+q9vAZWtQc23Wtq/5+Qtl+2xcFFalTxe4Cu6uXnxefdA65bS4Gbc
         qkz+5a/Kf5UXJ5l+A+thm69bTeWdUx/a3Xy+FVlm0EY2IG+NGiScvmqykhYy8u4iW+W+
         QN6Ff5+jc3ygV67Z1KbGVF7e70Pv38MfuS3H1SRTznYxJYstrUZJicyLJLrTSWeMBc1S
         zlpA==
X-Gm-Message-State: ACrzQf15tsOJHb0lZe2NoIF3+yH1HbY714mOHqCZxNjgHFuVSy+bPyo4
        Su12nHsudC5YEdKjQpEArcIIefF8QOimvWUMHIGSTNcPhRlYRktPpDvS73gBkKB0SDhBk7+ITK6
        nhcyBWB7pL+hSM/oIUcKvyCPltDs2EqqZ/ElEuw==
X-Received: by 2002:adf:fad0:0:b0:22e:4998:fd5d with SMTP id a16-20020adffad0000000b0022e4998fd5dmr2986820wrs.267.1666126464684;
        Tue, 18 Oct 2022 13:54:24 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM56AO+wk6RlK4KVfT9P3LmtwBvOvRZ6AIQAfU74yH274huUcfE7m3JRGMgA/Z6UR6c4Q7uE8soGGYtHsMbqYuw=
X-Received: by 2002:adf:fad0:0:b0:22e:4998:fd5d with SMTP id
 a16-20020adffad0000000b0022e4998fd5dmr2986803wrs.267.1666126464448; Tue, 18
 Oct 2022 13:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221018183540.806471-1-miquel.raynal@bootlin.com>
In-Reply-To: <20221018183540.806471-1-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 18 Oct 2022 16:54:13 -0400
Message-ID: <CAK-6q+gRMG64Ra9ghAUVHXkJoGB1b5Kd6rLTiUK+UArbYhP+BA@mail.gmail.com>
Subject: Re: [PATCH wpan-next v5] mac802154: Ensure proper scan-level filtering
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Guilhem Imberton <guilhem.imberton@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Tue, Oct 18, 2022 at 2:35 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> We now have a fine grained filtering information so let's ensure proper
> filtering in scan mode, which means that only beacons are processed.
>

Is this a fixup? Can you resend the whole series please?

- Alex

