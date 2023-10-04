Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB19EE776F4
	for <linux-wpan@archiver.kernel.org>; Wed,  4 Oct 2023 09:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbjJDJWN (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 4 Oct 2023 05:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbjJDJWN (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 4 Oct 2023 05:22:13 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869E4AB
        for <linux-wpan@vger.kernel.org>; Wed,  4 Oct 2023 02:22:09 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3226cc3e324so1850893f8f.3
        for <linux-wpan@vger.kernel.org>; Wed, 04 Oct 2023 02:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696411328; x=1697016128; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=60gbEhWeq8J+ivtYgPXcgmmUpJBTWg2RHo47BE0QpvU=;
        b=lAYkgPGC6vlDqbJKOJSW9oM9Cf82+B1WDRSP94LLVXWZL53wD6VaFs219fMk4jDqdt
         3iPgVQALkoGl/dZdD3KJa8Ke1zFQKqcuR7MXLgV0jayKtJysGqXf2E4ZnGFTyYDRUxKI
         oAAd3ISdbgGY4PVREncsTi+XjiBxW+awV8ZdXhNIsDnng/4hthH2hGYDQYfXiXBYU6sV
         pPJkxAArXRK5nk087B0XP8Kv517lXTe471ue7vfSAnc1mU0DzEXQH8iHQ6lw/ulC5mod
         pr3o4Dk5hG9lFXj4C/u+FQ1BlExLlxurTmamu2ruEugG2MY5/9xC8mhV5g2sSKO914hh
         h+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696411328; x=1697016128;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=60gbEhWeq8J+ivtYgPXcgmmUpJBTWg2RHo47BE0QpvU=;
        b=Jd8OZYTQe98ND62yTiqWmMftm3fK6SL1YZlfO60zAk23BVSatT/LfE85r7srAb4xc9
         TNhv2lpVh7fiGZP7J85wsczpLv9gzYlQ2M2yM9+tZc9FiCHlc1CUn4FzE2dXAtCqQXjj
         CYPX+Bdp/tbrcdhXIIvUk6nytp0PnF6HmPsGFyDryvhViIFuH9uqE9tAQ1bqtKPHgm3c
         Pkg/9vDhm795+tFzdqkPEEiO6AQ9PsykkU6gXaa+XJmLGibkzNJBfMjuDkalArrYHE84
         MDn9099hk40/dCzPlkDozd7dW5/OVdqbbYj9ZMaNuDy8iv5Zpe6UE4V6JDszwBaApjgz
         kI+Q==
X-Gm-Message-State: AOJu0Ywau+AASG5KF3cbBqOr9PAgFRd2qz9rClRKIwrtaxHQkpW7YBXv
        Hc0dmnR1CkyWCpfGYUP57tAHrA==
X-Google-Smtp-Source: AGHT+IFF519QprsBCJA7c7CUDqtHJ9oTO4EDKr8dD5MK+GaPkQNorbw/6dYKdiZ8MBt3fcugtqWK0Q==
X-Received: by 2002:adf:db50:0:b0:327:d08a:1fb3 with SMTP id f16-20020adfdb50000000b00327d08a1fb3mr1519689wrj.35.1696411327815;
        Wed, 04 Oct 2023 02:22:07 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id a10-20020adfeeca000000b0032008f99216sm3508989wrp.96.2023.10.04.02.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 02:22:06 -0700 (PDT)
Date:   Wed, 4 Oct 2023 12:22:02 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Alexander Aring <alex.aring@gmail.com>
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Angus Chen <angus.chen@jaguarmicro.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Joel Granados <joel.granados@gmail.com>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH net] 6lowpan: fix double free in lowpan_frag_rcv()
Message-ID: <3c91e145-5cd5-4d9d-9590-3b74b811436a@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

The skb() is freed by the caller in lowpan_invoke_rx_handlers() so this
free is a double free.

Fixes: 7240cdec60b1 ("6lowpan: handling 6lowpan fragmentation via inet_frag api")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
From static analysis, untested.

 net/ieee802154/6lowpan/reassembly.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index 6dd960ec558c..1ccefc07049c 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -313,7 +313,6 @@ int lowpan_frag_rcv(struct sk_buff *skb, u8 frag_type)
 	}
 
 err:
-	kfree_skb(skb);
 	return -1;
 }
 
-- 
2.39.2

