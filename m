Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D067E43CEF3
	for <linux-wpan@vger.kernel.org>; Mon, 21 Sep 2026 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789976531; cv=none; b=rSUD+FOrUkVag5mj1xwu/JY6Blq+6ovFvbv4lxQRrGC7AgHz45GYZk0bQccPDPcmrlu3eeusIs0Wx0raz4AtBvki5MG5hXvp6pg0A9byQBsDaYII2dm8nIJfl5CzJVGXqbVjUblrGVNdTs2m6QfVoPb5v+G3Wvp4+oC5ffGO1g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789976531; c=relaxed/simple;
	bh=HBE/+kSisSLQtTti9PD0IF4r82pEZs1xT/tQKJlZHgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gUNPiTMXHFtsSRqmkTxesxTSbqSeHuV5cWH0Z/S+Hl42fn0K/krelO4EMShU7keOAIRqVbG82oGa+OhPCv0o9Dtg9aztroFU/ekWHVVW+rZWBnjzvZQdOdsL4gIzAMBuroh95CiJMvHapt01PHnPJGLKMvcZDqqldQohdKIn/58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rDIHpsbK; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rDIHpsbK"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469b35611so1672144b3a.0
        for <linux-wpan@vger.kernel.org>; Mon, 21 Sep 2026 00:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789976529; x=1790581329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EpPg8uLiGCt1nmkqruCW0RWeQqwd9zjhCiMPftKkUsQ=;
        b=rDIHpsbK0Tl8HpuwCfE4/CmCKps1Zep2g4sz/H9wvWTa8ogLLKX1qn05qcQHaBjC+O
         b6YK5UlXhSxpiD/mqjHdGsQEvp29yx+wBNsDkM/6K0SdUQCIMAd23w+gGwcwAsC4aDfp
         gnCOhU5JhFAVvhtjhmyOOIk9Av8ABgooYYYbIkLM1TTQn6OJUwIsJ0Y++v5vkJZVQNYM
         NZQbNJMRHR0gjevbWrQL09gyOqnOQBKsxa5auG0NcNT3OAsog9GrZejE7oS4mRRtT9Vg
         KtLvAaeSL2OWXwl309uKiTZ23ntLY6OUQ8MYyIxFa/GNiEqe4/TvauISNVCCiJITvqqj
         EMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789976529; x=1790581329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EpPg8uLiGCt1nmkqruCW0RWeQqwd9zjhCiMPftKkUsQ=;
        b=gw1rflmUmynszmq3oE9VOvyPPxsH35O6e/3PY9BzZOjK4Xf9ivhcxnD2Lrr55dUWUs
         s+E5P6qL0U2MlBvsHRcRGZbHrd1fn2hdXxOkJkGhAkzcipTLA6Plif2gyfT07J0IINo6
         iPoIOT8IPptlghaZoJW1bpVC5KdqHZsfun23uegGbPC2V5kBjXmkY+8fRT4jxuFjZ0ep
         r3fjL3FcUC+RblTCY65PKhOemUu1w1NE0+3OSN8lbMeXQ1IxbihOQ9+n4Avj9s/gD9p/
         svCBp/N6RxAkWKiqVzGrt8yCwuXRLisnoY3Ycp0iKyckqNKEmQpjK6W1kCkasmZGjYvy
         /Z7A==
X-Gm-Message-State: AFuF++lMz8HPY01IFSYSvTGBgWkehnYxvz1oQesfKDqjASIKhYDN6ye8
	gVuOmjTsPBWWfDLOja1SXhsvjzImGTdijCRjbxno7wwrLZaJGOUW7Wfm0Yb4CJZW
X-Gm-Gg: AYBFou1w6k5S9w/rNlY5S3gD0No6xnRXe0946CDZ7QJCd72MaI2Uy7F2yKWGYt+zs1M
	J3ub4RDlU0kW+O+VJzjTa91wBpZ+uGhGxW2OINFijn5+6mGwIlA2WPBIv4reuPKui7JKrRAuR6e
	6B2hzSRsxc5b8nDQWy8UwI2ORrmZ90mExHxDp3KT+NN1MH3YAZoX/uIN6sbbXiyFvKdx9BLrVRW
	ee35QUZJHD+2MVGQWjuW4IdaOsOYXvkYl1J8dc+YKlOkanfrwcdl17vgrTRFoJGbIjZlGsxc7Iy
	q0jKfVCx09qLlAs0cN5t1lUpexNyL4/1NZmOHHPAOhalpTAvvzTmOPjqXUOiRT09Zt2mTTke1ie
	4DqFX0LfZmJANBIV6oaEXxOtfBx43wiV3obuBP4OEQMS4RpjdzLbqc0x0uLy+Vs676qwEtQRlQO
	s72I1Bn9zF/r6QgTqWHpND8na5EkJ131z2SwNhqIIzRPPJL/eROOETLun3vDk4vwpfCE84FOVmJ
	NzW3aLsGTD44ov05vUqDG7XwEWlKxq4NDjW4/y5njBtSTfMDuq/dNcAh8eQVDpNwDzXegowsJvt
	hNOonYKbwA==
X-Received: by 2002:a05:6300:85:b0:3dd:a195:dd57 with SMTP id adf61e73a8af0-3dda195e4bemr10090144637.57.1789976528682;
        Mon, 21 Sep 2026 00:42:08 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc72ae70637sm3048650a12.6.2026.09.21.00.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 00:42:08 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui Peng <benquike@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 2/4] ieee802154: cc2520: flush fifop_irqwork before destroying buffer_mutex in probe
Date: Mon, 21 Sep 2026 07:42:05 +0000
Message-ID: <20260921074207.2289391-2-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260919213639.3316625-1-benquike@gmail.com>
References: <20260919213639.3316625-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In cc2520_probe()'s err_hw_init path, mutex_destroy(&priv->buffer_mutex)
is called before flush_work(&priv->fifop_irqwork). If fifop_irq fires
after devm_request_irq() and schedules priv->fifop_irqwork before probe
fails, cc2520_fifop_irqwork() can lock priv->buffer_mutex after it has
already been destroyed:

  BUG: KASAN: slab-use-after-free in assign_work+0x2f1/0x340
  Read of size 8 at addr ffff88800246b0b0 by task kworker/1:1/43
  Workqueue:  0x0 (events)
  Call Trace:
   <TASK>
   dump_stack_lvl+0x70/0xa0
   print_report+0x153/0x4c6
   kasan_report+0xf1/0x120
   assign_work+0x2f1/0x340
   worker_thread+0x2b8/0xb70

Flush priv->fifop_irqwork before mutex_destroy(&priv->buffer_mutex),
matching the teardown order in cc2520_remove().

Tested in QEMU with KASAN enabled by scheduling fifop_irqwork on the
cc2520_probe() error path.

Fixes: ff5891b266a7 ("ieee802154: cc2520: fix FIFOP work use-after-free")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split out as patch 2/4 and documented the probe cleanup ordering fix and
  Fixes: tag as requested by Miquel Raynal.

 drivers/net/ieee802154/cc2520.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index 5454872..d2c8484 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -1153,8 +1153,8 @@ static int cc2520_probe(struct spi_device *spi)
 	return 0;
 
 err_hw_init:
-	mutex_destroy(&priv->buffer_mutex);
 	flush_work(&priv->fifop_irqwork);
+	mutex_destroy(&priv->buffer_mutex);
 	return ret;
 }
 
-- 
2.47.3
