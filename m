Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7024D3E7BC6
	for <linux-wpan@vger.kernel.org>; Wed, 20 May 2026 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286619; cv=none; b=PN/PgZbmpvt6LAJgE5I4RjyOkNtmFmIv1G6chrjZ1PXOG9rH0MDR7gIcYncA/Zqkz4OhU2SWw/YYoGxgkn5q/x6ifUqWWE+mhXWbCuatHL0pG7NUXslrMVoN5XmdGVJyOeSVq1X8KMoJP0gRZFBuq1StBiwIHwqv13w0qJjY6tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286619; c=relaxed/simple;
	bh=WjKqJkiCTtmvejCIJSk2+o8+CaSQCH4dCt3cUySSNT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNaHefl4o/LC6y5tdNR3n5nWwW6349maNaz/Uwi4bSdo2+P64wWi04hM1SDs2q4RSlxlwQLFqSWSKtKi36bK/VFXl9Otwrtnj7JQ8PsQrfb8CXQsz927tI6I3sZihDUBswLbNR3LMQJq3K3sd3y85XBHH6xG8TcnHPL8TqDH9n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVQyWPAT; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVQyWPAT"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-6314adf187fso1468329137.0
        for <linux-wpan@vger.kernel.org>; Wed, 20 May 2026 07:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779286616; x=1779891416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rx7r4Y10liUqwimwJdlvRGNK/vx0KHWn1LAYPWA617s=;
        b=WVQyWPATep/Iwv/N0fjKzeadrtnVzQp0seoFvJBZam/ptuvhzMcGrSIdjsdAHi5gAi
         6NRIkIE7zMI06DbifRdAjjhcs8G4cQteNNB791/qKH5GPtekoTgyY+r20//OeqFWz9Mp
         HNEudbUCzaVJ9nFQfkiIkYb8uKR4Ec9n/cJco+NypUUaztJeK9cqJrDahlPR5aKW598d
         q6qAcDEokJE1vtPhBit+iPRgkcOOgCHqE+TDocLUPPUi3ezk7t+xnavEDVi1gg7lbMyH
         FXm52GznWG9hTdzSnGWxUYwAUuCCGdU+Ln4nzYhyT0EVEg00A9AIjdjXyIWU2EFfiWbT
         ObYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779286616; x=1779891416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rx7r4Y10liUqwimwJdlvRGNK/vx0KHWn1LAYPWA617s=;
        b=H4mLn9uNPW0XoiIqN2BwqtdLlZ/rA9+9UcaxByqudoyvFkzgz+ldSvyyvsNGLoxQlQ
         4lIScWRPJFcOI+6MmHnWWPRKXp3lEk6K70GbMVAtrcJEQaYFtE9G/4GDpJ+kyTuuNT2U
         LrVpLZdVq8YMLqUq1c77L1M2EOrV8qcim4njb5c0KQEUyHyJbc37hlxcoFYqPPyCkNT0
         OxY9llCKYp/DNwEXi0l9gPQ9BBCr+koI+jkKtLT394+dz6cn9sbz/YKd/CSQAmsTzWJq
         fvVl1Ahr8j5EmWDX4vqLCSI7Dgn0Hg3tndbTroD4NKMjhka7K+J1WK/eIdAx1uZkPZP3
         TgvA==
X-Forwarded-Encrypted: i=1; AFNElJ9350BEBV4vscB2MDLkPJj3cdFDBppyAR98YqKwVLypDICwtB2Yw6NrplLgb1rh0nQ0rBerIOBsppCJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwHfjZeydt2chBG8ZQaQwcQh1gY06T6ZZJIxDj7St436VSnivVl
	K5v7o2v8xa3hxjDuYuJ8BNaYo9MZQ2OmvB8bRxhj61u9SyehCzBTuVdA
X-Gm-Gg: Acq92OGhu3rKtPv9C/m9tpJo5JtxBIAcJ73XvMhKUpWE4QWQEWlZeFT8Hs0iYxELo3J
	QCWIZ/7IsCI+ojZFKnrV81VJnkbhQ53bCSRX1rIn2qSMtkxQHQgd+o90YUsFQYfkp+cwSfcYheD
	Q/EoXlM1vKStRK7DdbZd/8NDIErIGDpxKE/oYmtRH9VZmJWOQz30AGEd2ekTDV8M9K2DWO5WSsE
	b0pLBgWeI9iV9rpQXuHMnhWzsYxkorh+1G7PP2B7IzXSFwj7jVAcrLdt/6Vqa1BErwLAC3E2E3A
	JMnWjxlwWyYQA2DUFvFXU9nHYTimpvf0McuLPTfX26uu0d1NP10u+HU3d+zWXmiKVc6NuvWiQ9q
	a8qSM9rza7yssX/95DL5V71wn/ZIsxYV/gO5y95C9RiS0pJhwD/LF2Yv50QjpXryqzArLpyV14z
	lpQ9Oumid/LJyj9EdAvb90f3sSBjhmfS2kc9vzAiUuUXRHW9w2FNWSGVLICVtm+3dLpTkhhblTf
	GL7bTPk4mLi07vCeCnObtQ6O9xVzDY=
X-Received: by 2002:a67:e105:0:b0:611:61d3:819c with SMTP id ada2fe7eead31-63a3cf120a2mr11450388137.10.1779286616271;
        Wed, 20 May 2026 07:16:56 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba463814sm2138952485a.5.2026.05.20.07.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 07:16:55 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] ieee802154: allow legacy LLSEC ADD/DEL ops to pass strict validation
Date: Wed, 20 May 2026 10:16:40 -0400
Message-ID: <20260520141640.1149513-3-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520141640.1149513-1-michael.bommarito@gmail.com>
References: <20260520141640.1149513-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

The LLSEC ADD/DEL doit handlers under the legacy IEEE802154_NL family
consume IEEE802154_ATTR_LLSEC_KEY_BYTES and
IEEE802154_ATTR_LLSEC_KEY_USAGE_COMMANDS, both declared in
net/ieee802154/nl_policy.c as bare length entries with no .type
(defaulting to NLA_UNSPEC). Generic netlink strict validation rejects
all NLA_UNSPEC attributes via validate_nla(), so every LLSEC_ADD_KEY,
LLSEC_DEL_KEY, LLSEC_ADD_DEV, LLSEC_DEL_DEV, LLSEC_ADD_DEVKEY,
LLSEC_DEL_DEVKEY, LLSEC_ADD_SECLEVEL, and LLSEC_DEL_SECLEVEL request
fails at the dispatcher with "Unsupported attribute" before reaching
the handler.

The doit path has been silently dead since strict validation became
the default for genl families that do not opt out. The dump path is
unaffected because dump requests carry no LLSEC attributes to
validate, which is why the LLSEC_LIST_KEY read remained reachable
(patch 1/2). Introduce IEEE802154_OP_RELAXED() mirroring
IEEE802154_OP() but with .validate = GENL_DONT_VALIDATE_STRICT, and
use it for the eight legacy LLSEC mutate ops so admin-driven LLSEC
configuration via the legacy interface works again.

Fixes: 3e9c156e2c21 ("ieee802154: add netlink interfaces for llsec")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/ieee802154/ieee802154.h |  9 +++++++++
 net/ieee802154/netlink.c    | 20 ++++++++++----------
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/net/ieee802154/ieee802154.h b/net/ieee802154/ieee802154.h
index fd9778f705503..e765adc4b88f2 100644
--- a/net/ieee802154/ieee802154.h
+++ b/net/ieee802154/ieee802154.h
@@ -16,6 +16,15 @@ void ieee802154_nl_exit(void);
 		.flags	= GENL_ADMIN_PERM,		\
 	}
 
+#define IEEE802154_OP_RELAXED(_cmd, _func)		\
+	{						\
+		.cmd		= _cmd,			\
+		.doit		= _func,		\
+		.dumpit		= NULL,			\
+		.flags		= GENL_ADMIN_PERM,	\
+		.validate	= GENL_DONT_VALIDATE_STRICT,\
+	}
+
 #define IEEE802154_DUMP(_cmd, _func, _dump)		\
 	{						\
 		.cmd	= _cmd,				\
diff --git a/net/ieee802154/netlink.c b/net/ieee802154/netlink.c
index 9c9fd14d0ca8b..cacad21347eca 100644
--- a/net/ieee802154/netlink.c
+++ b/net/ieee802154/netlink.c
@@ -100,22 +100,22 @@ static const struct genl_small_ops ieee802154_ops[] = {
 	IEEE802154_OP(IEEE802154_LLSEC_SETPARAMS, ieee802154_llsec_setparams),
 	IEEE802154_DUMP_PRIV(IEEE802154_LLSEC_LIST_KEY, NULL,
 			     ieee802154_llsec_dump_keys),
-	IEEE802154_OP(IEEE802154_LLSEC_ADD_KEY, ieee802154_llsec_add_key),
-	IEEE802154_OP(IEEE802154_LLSEC_DEL_KEY, ieee802154_llsec_del_key),
+	IEEE802154_OP_RELAXED(IEEE802154_LLSEC_ADD_KEY, ieee802154_llsec_add_key),
+	IEEE802154_OP_RELAXED(IEEE802154_LLSEC_DEL_KEY, ieee802154_llsec_del_key),
 	IEEE802154_DUMP_PRIV(IEEE802154_LLSEC_LIST_DEV, NULL,
 			     ieee802154_llsec_dump_devs),
-	IEEE802154_OP(IEEE802154_LLSEC_ADD_DEV, ieee802154_llsec_add_dev),
-	IEEE802154_OP(IEEE802154_LLSEC_DEL_DEV, ieee802154_llsec_del_dev),
+	IEEE802154_OP_RELAXED(IEEE802154_LLSEC_ADD_DEV, ieee802154_llsec_add_dev),
+	IEEE802154_OP_RELAXED(IEEE802154_LLSEC_DEL_DEV, ieee802154_llsec_del_dev),
 	IEEE802154_DUMP_PRIV(IEEE802154_LLSEC_LIST_DEVKEY, NULL,
 			     ieee802154_llsec_dump_devkeys),
-	IEEE802154_OP(IEEE802154_LLSEC_ADD_DEVKEY, ieee802154_llsec_add_devkey),
-	IEEE802154_OP(IEEE802154_LLSEC_DEL_DEVKEY, ieee802154_llsec_del_devkey),
+	IEEE802154_OP_RELAXED(IEEE802154_LLSEC_ADD_DEVKEY, ieee802154_llsec_add_devkey),
+	IEEE802154_OP_RELAXED(IEEE802154_LLSEC_DEL_DEVKEY, ieee802154_llsec_del_devkey),
 	IEEE802154_DUMP_PRIV(IEEE802154_LLSEC_LIST_SECLEVEL, NULL,
 			     ieee802154_llsec_dump_seclevels),
-	IEEE802154_OP(IEEE802154_LLSEC_ADD_SECLEVEL,
-		      ieee802154_llsec_add_seclevel),
-	IEEE802154_OP(IEEE802154_LLSEC_DEL_SECLEVEL,
-		      ieee802154_llsec_del_seclevel),
+	IEEE802154_OP_RELAXED(IEEE802154_LLSEC_ADD_SECLEVEL,
+			      ieee802154_llsec_add_seclevel),
+	IEEE802154_OP_RELAXED(IEEE802154_LLSEC_DEL_SECLEVEL,
+			      ieee802154_llsec_del_seclevel),
 };
 
 static const struct genl_multicast_group ieee802154_mcgrps[] = {
-- 
2.53.0

