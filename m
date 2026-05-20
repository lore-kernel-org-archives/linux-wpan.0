Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4FC3E92B7
	for <linux-wpan@vger.kernel.org>; Wed, 20 May 2026 14:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286617; cv=none; b=I/MgcVEL/PGCrglREhZK42ZzmEhKVZdMw0L2Ke3lsryxhyWJ7EauMJDuBP1U+jX2ZeQNltXWscL0nEXNqRuwSv9eItHUOh08fqCmZFiPPAdTqd30R5bKoNg4snf0FqUheaWugwTxTVR8zAldgRgL85jVGDsQGfB2vLTYutbSUuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286617; c=relaxed/simple;
	bh=7VFZ8F94wUu3BpT39Q6/44VPVbdrgBiUVDnaIyTiW3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d3XSxC++cPzhWBl+DSudlQUrwsw+Y2xBpTFl+LPkXFrJJP83DSRuyxtuuxUYND4S9J81TJffjJps9GCIQEwTa2U1TjzaEdWo/wo/QluWnhP5IxEzJESeCfh8kzpRUpTsuEdN4bf9GXzXODPfA2vLmMAtWF+ef4VfmI+P+uQqsfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtHeL0SM; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtHeL0SM"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-65c477a3278so5154861d50.3
        for <linux-wpan@vger.kernel.org>; Wed, 20 May 2026 07:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779286614; x=1779891414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hRZUQeBmoTEstKWsMVlBg95hUFZXrJz+CK/C25lcLP4=;
        b=DtHeL0SMpDUYpXw44zCMEZvu1us6W32DyOVRj7rWQDysBuNQvj5o22ojsuiHZCVR2g
         ynI0uFOKi8UP2Y6EB+FDkT4JkJiqUA9YCiiuK2jLkUtJ6sTfeYHuXK+YG/1BYzIVLyCs
         ILCWPUcAxhfLV/0cDyHeJL/huhKC4njaiwvuSVi2PFg5mywnQmq7oSKl3mEVT9sxvX1V
         HhLjDCF7ac4x2gYSkx3FVwJr31DlTiLvEhbBm9p2hMqqSHLtWyVE+VYB3sQofHUj5D+V
         gXHFXzp58mmJ2aLA1aWohq6zoczHlsmUiGqo5w0VrT8JHioxDje2HUjBbE1COSXTX4TT
         a+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779286614; x=1779891414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRZUQeBmoTEstKWsMVlBg95hUFZXrJz+CK/C25lcLP4=;
        b=VQfnZt9KH3XyArF9kXdnxnym0F19uyIzdWwf4rtAz6CEmLAuaYrTY2uY5HgXaPMTAH
         IB6ZqtakiM28/Psb5q7uNHUZ/UMrlpxSZfT/Cqd5RYNZf/cHfE4dql+8CODR1KXi0uNu
         BrSYepZqObup59IFRitMpbeOqL2e05SDZCQ5zbDVjnRaCvxdnuVGAQnRJ7xin0JRIwJu
         QOneXpjzDuuwP2iNGS6WkiPl8/0Bs35xs9M1mDppFYBHhdWaQEszDpZDvx3LXCBKwBuh
         qDSIU3VM94DsDkCrWfPpejjpWo9kyeFpDGuY01w3op2p5pJM3+p41Lo3iRcMG0d5tZI5
         Ortg==
X-Forwarded-Encrypted: i=1; AFNElJ9l8cpLqrBNfcKNdXfFLJ1+00Sr/XQP4nSHYqh1w3filz+5qAuu1q8Nh51i3GsNJoJCLoUaagEek13h@vger.kernel.org
X-Gm-Message-State: AOJu0YwczINfwwD14W+kUsBwkh810zV2NivGc1H54hZZl/9ylrkeMrde
	C5RUkInKEa7kT5fFjmIkv1a2+Cl3jxRVu7gPe/Jk8i/Bo+HeUcSM9yb8
X-Gm-Gg: Acq92OGBKjSQT1IN0PXcGmKz+RWYzyRBhPJQlvQQY5rhl79E0FhLklCm/ognAdXs87r
	7CKQFFWpXwxluca4NcJv4+dOyv4+lxeFFzZyBVDSG+e4PyDfYF5MsF3ITBaV7qreZ411iqquVuk
	Ybif7usSZxFc1I+YNkLBPHgusGVXtrDo6YuArDby+gK3V973y1WXQCg+qRBCXW8tkBhJqgGf6Fx
	aIBGvre5KC7kTQZa2HlMBup1XPhp0twmsQ+BTamVMkBux1+C1oWmECWJIH9hXI3O6VKkXB+pAYK
	id+U/hKUZ00FETOQJYBsTLkhWExf/2wL06dTyE2NUQto3BRQXTNO6i/4a1x/1iXhHj2IOeEMUaq
	TDTBlR+G0iOUeYiXdYml1V4I3jctXJiGvdOQ/IlLfDBtwTpW+2qYKh4rM1xPRiFt6bttcY/YwKK
	W/Acf/UkaR66OGzBqq1zN4URqKpJzr6//ILamRuS16YM7iwC5CWMsr1KIc2pb50F21ZHoLktZZk
	rx2cUJ2CI6ZpzwHJkPg4qFi9xTq40E=
X-Received: by 2002:a05:690e:4415:20b0:654:5d65:9fe1 with SMTP id 956f58d0204a3-65e22678067mr19136094d50.8.1779286613949;
        Wed, 20 May 2026 07:16:53 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba463814sm2138952485a.5.2026.05.20.07.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 07:16:53 -0700 (PDT)
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
Subject: [PATCH net 0/2] ieee802154: admin-gate legacy LLSEC dumps + un-deaden ADD/DEL
Date: Wed, 20 May 2026 10:16:38 -0400
Message-ID: <20260520141640.1149513-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

The legacy IEEE802154_NL family (net/ieee802154/netlink.c) builds its
ops table from two macros in net/ieee802154/ieee802154.h. IEEE802154_OP()
sets .flags = GENL_ADMIN_PERM; IEEE802154_DUMP() sets no flags. Among
the IEEE802154_DUMP() consumers are four LLSEC dump ops (LIST_KEY,
LIST_DEV, LIST_DEVKEY, LIST_SECLEVEL), and the LLSEC_LIST_KEY dump
handler at net/ieee802154/nl-mac.c emits the raw 16-byte AES-128
keytable bytes (IEEE802154_ATTR_LLSEC_KEY_BYTES, .len = 16, copied
verbatim from struct ieee802154_llsec_key.key) into the reply skb.
The modern nl802154 family admin-gates the equivalent reads
(NL802154_CMD_GET_SEC_KEY at net/ieee802154/nl802154.c:2978 with
.flags = GENL_ADMIN_PERM) so the legacy interface is the open side.

Any local uid with no capabilities can dump the AES-128 LLSEC keytable
of any wpan netdev that has an administrator-installed key. 802.15.4
LLSEC uses CCM*, so the same key authenticates and encrypts frames at
the chosen security level. One key leak compromises confidentiality
and authenticity at the link layer.

Patches:

  1/2 ieee802154: admin-gate legacy LLSEC dump operations
      Introduce IEEE802154_DUMP_PRIV() mirroring IEEE802154_DUMP() but
      with .flags = GENL_ADMIN_PERM. Switch the four LLSEC dump ops to
      it. LIST_PHY and LIST_IFACE keep IEEE802154_DUMP() because the
      modern nl802154 family exposes their equivalents to unprivileged
      readers by design.

  2/2 ieee802154: allow legacy LLSEC ADD/DEL ops to pass strict validation
      While reproducing the dump leak the LLSEC ADD/DEL doit handlers
      turned out to have been silently dead since strict netlink
      validation became the default: IEEE802154_ATTR_LLSEC_KEY_BYTES
      and _KEY_USAGE_COMMANDS are declared as NLA_UNSPEC in
      nl_policy.c, which validate_nla() rejects under
      NL_VALIDATE_STRICT. Add IEEE802154_OP_RELAXED() with
      .validate = GENL_DONT_VALIDATE_STRICT and switch the eight LLSEC
      mutate ops to it. The dump ops keep strict validation; their
      gate from patch 1/2 stands.

This would be a good time to revisit this thread from Alexander Aring:
https://lore.kernel.org/r/20160725121450.4093-4-aar@pengutronix.de

Ten years later the legacy interface is still in mainline and
(per patch 2/2) silently dead on the doit side anyway. Maintainers
who prefer to revive that deletion series should NACK patch 2/2 and
pick patch 1/2 alone; patch 1/2 plugs the key leak whether the
legacy doit path is ever brought back to life or removed entirely.

Reproduction
============

Tree: mainline 7.1-rc2 (22be7671cc3497f68d14555285c0ac221597c8eb),
x86 UML, KASAN off. Conditions: CONFIG_IEEE802154=y, CONFIG_MAC802154=y,
CONFIG_IEEE802154_HWSIM=y; one wpan netdev exists; an administrator
has installed an LLSEC key on it.

Harness: a userspace C program opens AF_NETLINK / NETLINK_GENERIC,
resolves the "802.15.4 MAC" family, and issues a CTRL_CMD_GETFAMILY
followed by a IEEE802154_LLSEC_LIST_KEY dump on wpan0. The dump
response is parsed for IEEE802154_ATTR_LLSEC_KEY_BYTES nested
attributes and the 16-byte payload is hex-printed. The runner drops
privileges to uid=1000 via setpriv with --bounding-set=-all and
--inh-caps=-all before invoking the dump.

For patch 2/2, the same harness shape sends a IEEE802154_LLSEC_ADD_KEY
request with policy-conformant attributes (frame counter, key ID
mode, key bytes, usage frame types) as root. The harness measures
whether the doit handler is reached (ieee802154_llsec_add_key()
return code visible via the netlink ack) or the dispatcher rejects
the request at the validate phase.

Stock vs patched outcomes (per patch):

  1/2: stock dump returns the installed AES-128 key bytes
       byte-identical to the unprivileged dumper; patched returns
       -EPERM at the generic-netlink dispatch.

  2/2: stock LLSEC_ADD_KEY as root returns "Unsupported attribute"
       from __nla_validate_parse(); patched reaches
       ieee802154_llsec_add_key() and installs the key.

Regression-adjacent runs (per patch):

  1/2: LIST_PHY and LIST_IFACE dumps continue to succeed from an
       unprivileged uid post-patch, mirroring the modern
       NL802154_CMD_GET_WPAN_PHY and NL802154_CMD_GET_INTERFACE
       behavior.

  2/2: modern nl802154 NL802154_CMD_NEW_SEC_KEY (which is admin-
       gated and uses NLA_NESTED policy entries, not NLA_UNSPEC)
       continues to install keys unchanged.

Mitigations: a system administrator unwilling to ship patch 1/2
can mitigate the leak by building the kernel without
CONFIG_IEEE802154 or by ensuring no LLSEC key is installed on
any wpan netdev. There is no per-process mitigation.

Selftest gate: tools/testing/selftests/ has no matching binary
for the legacy IEEE802154_NL interface.

The trigger harness sources are available off-list on request.

Scope notes:

  - The dump handler reuses the same struct ieee802154_llsec_key
    storage as the modern nl802154 NEW_SEC_KEY path. Both interfaces
    expose the same backing keytable; gating only the legacy dump is
    the minimal fix.
  - The two new macros sit alongside the existing two; no existing
    callers change beyond the four LIST_LLSEC* lines (patch 1/2)
    and the eight LLSEC ADD/DEL lines (patch 2/2).

Michael Bommarito (2):
  ieee802154: admin-gate legacy LLSEC dump operations
  ieee802154: allow legacy LLSEC ADD/DEL ops to pass strict validation

 net/ieee802154/ieee802154.h | 17 +++++++++++++++++
 net/ieee802154/netlink.c    | 36 ++++++++++++++++++------------------
 2 files changed, 35 insertions(+), 18 deletions(-)


base-commit: 22be7671cc3497f68d14555285c0ac221597c8eb
--
2.53.0

