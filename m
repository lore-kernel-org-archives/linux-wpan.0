Return-Path: <SRS0=5gwn=BM=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46D8C433E1
	for <linux-wpan@archiver.kernel.org>; Sun,  2 Aug 2020 14:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83FC320759
	for <linux-wpan@archiver.kernel.org>; Sun,  2 Aug 2020 14:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D7nVgHf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgHBOXx (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 2 Aug 2020 10:23:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29006 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725780AbgHBOXv (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 2 Aug 2020 10:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596378230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=2/kHNXwW/Okw1oeFagoA94XTuvPYMO2ieikygdNu33E=;
        b=D7nVgHf1S3i/q8yxrdZuEgxCrjAlZpEdFUwF/1KqORk3jg55ubGt6y9XT2FoqiKmZfpWo+
        SYh8nyw0VEvsxh6pSHSC2tUZZkYJr/HrMU0dd19myDVN40oF6iHTWhwMJysmAnjWtxU3ao
        T7vXowN1G/vi7KfHC1126hV7qEwJiZ4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-0Lqg6mlMODCYJM_4qej-kA-1; Sun, 02 Aug 2020 10:23:46 -0400
X-MC-Unique: 0Lqg6mlMODCYJM_4qej-kA-1
Received: by mail-qt1-f198.google.com with SMTP id q19so15405439qtp.0
        for <linux-wpan@vger.kernel.org>; Sun, 02 Aug 2020 07:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2/kHNXwW/Okw1oeFagoA94XTuvPYMO2ieikygdNu33E=;
        b=ioWXLTSZgZri5bggTZkQ3XOKtucxxIQSyHYhyAjqsIcKImNuFGI8kptRC2kM5raUkl
         GQtQMTJZIFtC1pdaJiS8FyLWEOTAhqLkItNNs9tw07xlM31c7NjJf22zs17n2HLHDaVO
         2lCIxbX/pWolur7s1TweKPU6iQkz8qnyxlh9Wh1lao97wKwsUxVyHZdTjX5qg8vMEk8a
         LEhuAFhvdwH1sfpVWwq/uA4M7GBp7UN49abbweriixA4cIPEzcV3tjovvpqXw9CEP/H8
         QSZda55G5Xdr7roBopHMzYYLatRMaq4du2+pw7jwmaAHrQsy9TR7H/W1TGzEdDS8vC+9
         2Bag==
X-Gm-Message-State: AOAM5314moytFnd7zQU18gXsE9Sfvt2UHYE/7NnYO44E4sqtNnnJpfIL
        un92sELYqAkzva4JShswCXMVVC5InkYeF/gfb1v3VCiFM05BVHDXggxSUeV3Nm1aMDjCH1tIEI8
        ogopgeK7fMJ86AJLZi03wSw==
X-Received: by 2002:a37:62cc:: with SMTP id w195mr12855856qkb.33.1596378226330;
        Sun, 02 Aug 2020 07:23:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgE09Sl0MfhLOKvnnEluSkBTqBNuCaM3HjAVewFzyYuhdgdEgcM4E45wQlwXc1nshAvd3KIA==
X-Received: by 2002:a37:62cc:: with SMTP id w195mr12855832qkb.33.1596378226027;
        Sun, 02 Aug 2020 07:23:46 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id g61sm18050245qtd.65.2020.08.02.07.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 07:23:45 -0700 (PDT)
From:   trix@redhat.com
To:     michael.hennerich@analog.com, alex.aring@gmail.com,
        stefan@datenfreihafen.org, davem@davemloft.net, kuba@kernel.org,
        marcel@holtmann.org
Cc:     linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] ieee802154/adf7242: check status of adf7242_read_reg
Date:   Sun,  2 Aug 2020 07:23:39 -0700
Message-Id: <20200802142339.21091-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this error

adf7242.c:887:6: warning: Assigned value is garbage or undefined
        len = len_u8;
            ^ ~~~~~~

len_u8 is set in
       adf7242_read_reg(lp, 0, &len_u8);

When this call fails, len_u8 is not set.

So check the return code.

Fixes: 7302b9d90117 ("ieee802154/adf7242: Driver for ADF7242 MAC IEEE802154")

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/ieee802154/adf7242.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
index c11f32f644db..7db9cbd0f5de 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -882,7 +882,9 @@ static int adf7242_rx(struct adf7242_local *lp)
 	int ret;
 	u8 lqi, len_u8, *data;
 
-	adf7242_read_reg(lp, 0, &len_u8);
+	ret = adf7242_read_reg(lp, 0, &len_u8);
+	if (ret)
+		return ret;
 
 	len = len_u8;
 
-- 
2.18.1

