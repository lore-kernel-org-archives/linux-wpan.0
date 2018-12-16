Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32919 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730373AbeLPKUM (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 16 Dec 2018 05:20:12 -0500
Received: by mail-pl1-f195.google.com with SMTP id z23so4767736plo.0
        for <linux-wpan@vger.kernel.org>; Sun, 16 Dec 2018 02:20:11 -0800 (PST)
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: [PATCH v5 4/6] net: maclorawan: Implement the crypto of maclorawan module
Date: Sun, 16 Dec 2018 18:18:58 +0800
Message-Id: <20181216101858.9585-5-starnight@g.ncu.edu.tw>
In-Reply-To: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, "David S . Miller" <davem@davemloft.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: linux-lpwan@lists.infradead.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>, linux-wpan@vger.kernel.org, Jian-Hong Pan <starnight@g.ncu.edu.tw>

Implement the crypto for encryption/decryption and message integrity
code (MIC) according to LoRaWAN(TM) Specification Ver. 1.0.2.

Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
---
V2:
- Split the LoRaWAN class module patch in V1 into LoRaWAN socket and
  LoRaWAN Soft MAC modules
- Rename the lrwsec files to crypto files
- Modify for Big/Little-Endian
- Use SPDX license identifiers

V3:
- Order local variables from longest to shortest line in the functions

V4:
- Fix by coding style report from scripts/checkpatch.pl

 net/maclorawan/crypto.c | 212 ++++++++++++++++++++++++++++++++++++++++
 net/maclorawan/crypto.h |  27 +++++
 2 files changed, 239 insertions(+)
 create mode 100644 net/maclorawan/crypto.c
 create mode 100644 net/maclorawan/crypto.h

diff --git a/net/maclorawan/crypto.c b/net/maclorawan/crypto.c
new file mode 100644
index 000000000000..0ae9d211cd14
--- /dev/null
+++ b/net/maclorawan/crypto.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
+/*-
+ * LoRaWAN soft MAC
+ *
+ * Copyright (c) 2018 Jian-Hong, Pan <starnight@g.ncu.edu.tw>
+ *
+ */
+
+#include <linux/scatterlist.h>
+#include <crypto/hash.h>
+#include <crypto/skcipher.h>
+#include "crypto.h"
+
+struct crypto_shash *
+lrw_mic_key_setup(u8 *k, size_t k_len)
+{
+	struct crypto_shash *tfm;
+	char *algo = "cmac(aes)";
+	int err;
+
+	tfm = crypto_alloc_shash(algo, 0, 0);
+	if (!IS_ERR(tfm)) {
+		err = crypto_shash_setkey(tfm, k, k_len);
+		if (err) {
+			crypto_free_shash(tfm);
+			tfm = NULL;
+		}
+	}
+
+	return tfm;
+}
+
+int
+lrw_aes_cmac(struct crypto_shash *tfm, u8 *bz, u8 *data, size_t len, u8 *out)
+{
+	SHASH_DESC_ON_STACK(desc, tfm);
+	int err;
+
+	desc->tfm = tfm;
+
+	err = crypto_shash_init(desc);
+	if (err)
+		goto lrw_aes_cmac_end;
+
+	err = crypto_shash_update(desc, bz, 16);
+	if (err)
+		goto lrw_aes_cmac_end;
+
+	err = crypto_shash_update(desc, data, len);
+	if (err)
+		goto lrw_aes_cmac_end;
+
+	err = crypto_shash_final(desc, out);
+
+lrw_aes_cmac_end:
+	return err;
+}
+
+int
+lrw_set_bzero(u8 dir, u32 devaddr, u32 fcnt, u8 len, u8 *bz)
+{
+	__le32 le_devaddr = cpu_to_le32(devaddr);
+	__le32 le_fcnt = cpu_to_le32(fcnt);
+
+	bz[0] = 0x49;
+	memset(bz + 1, 0x00, 4);
+	bz[5] = dir;
+	memcpy(bz + 6, &le_devaddr, 4);
+	memcpy(bz + 10, &le_fcnt, 4);
+	bz[14] = 0x00;
+	bz[15] = len;
+
+	return 0;
+}
+
+int
+lrw_calc_mic(struct crypto_shash *tfm,
+	     u8 dir, u32 devaddr, u32 fcnt, u8 *buf, size_t len, u8 *mic4)
+{
+	u8 mic[16];
+	u8 bz[16];
+	int err;
+
+	/* According to LoRaWAN Specification Version 1.0.2
+	 * - 4.4 Massege Integrity Code (MIC)
+	 */
+	lrw_set_bzero(dir, devaddr, fcnt, len, bz);
+	err = lrw_aes_cmac(tfm, bz, buf, len, mic);
+	if (!err)
+		memcpy(mic4, mic, 4);
+
+	return err;
+}
+
+void
+lrw_mic_key_free(struct crypto_shash *tfm)
+{
+	crypto_free_shash(tfm);
+}
+
+struct crypto_sync_skcipher *
+lrw_aes_enc_key_setup(char *algo, u8 *k, size_t k_len)
+{
+	struct crypto_sync_skcipher *tfm;
+	int err;
+
+	tfm = crypto_alloc_sync_skcipher(algo, 0, CRYPTO_ALG_ASYNC);
+	if (!IS_ERR(tfm)) {
+		err = crypto_sync_skcipher_setkey(tfm, k, k_len);
+		if (err) {
+			crypto_free_sync_skcipher(tfm);
+			tfm = NULL;
+		}
+	}
+
+	return tfm;
+}
+
+struct crypto_sync_skcipher *
+lrw_encrypt_key_setup(u8 *k, size_t k_len)
+{
+	return lrw_aes_enc_key_setup("cbc(aes)", k, k_len);
+}
+
+int
+lrw_aes_enc(struct crypto_sync_skcipher *tfm, u8 *in, size_t len, u8 *out)
+{
+	SYNC_SKCIPHER_REQUEST_ON_STACK(req, tfm);
+	struct scatterlist src, dst;
+	u8 iv[16];
+	int err;
+
+	memset(iv, 0, 16);
+	/* The buffer for sg_init_one cannot be a global or const local
+	 * (will confuse the scatterlist)
+	 */
+	sg_init_one(&src, in, len);
+	sg_init_one(&dst, out, len);
+
+	skcipher_request_set_sync_tfm(req, tfm);
+	skcipher_request_set_callback(req, 0, NULL, NULL);
+	skcipher_request_set_crypt(req, &src, &dst, len, iv);
+	err = crypto_skcipher_encrypt(req);
+	skcipher_request_zero(req);
+
+	return err;
+}
+
+#define	LRW_SEQUENCE_OF_BLOCK_LEN	16
+
+int
+lrw_set_sob(u8 dir, u32 devaddr, u32 fcnt, u8 index, u8 *sob)
+{
+	__le32 le_devaddr = cpu_to_le32(devaddr);
+	__le32 _fcnt = cpu_to_le32(fcnt);
+
+	sob[0] = 0x01;
+	memset(sob + 1, 0x00, 4);
+	sob[5] = dir;
+	memcpy(sob + 6, &le_devaddr, 4);
+	memcpy(sob + 10, &_fcnt, 4);
+	sob[14] = 0x00;
+	sob[15] = index;
+
+	return 0;
+}
+
+int
+lrw_encrypt_sob(struct crypto_sync_skcipher *tfm, u8 *sob)
+{
+	return lrw_aes_enc(tfm, sob, LRW_SEQUENCE_OF_BLOCK_LEN, sob);
+}
+
+int
+lrw_encrypt_buf(struct crypto_sync_skcipher *tfm,
+		u8 dir, u32 devaddr, u32 fcnt, u8 *buf, size_t len)
+{
+	u8 sob[LRW_SEQUENCE_OF_BLOCK_LEN];
+	u8 i, j;
+
+	/* According to LoRaWAN Specification Version 1.0.2
+	 * - 4.3.3 MAC Frame Payload Encryption (FRMPayload)
+	 */
+	for (i = 0; (i * LRW_SEQUENCE_OF_BLOCK_LEN) < len; i++) {
+		lrw_set_sob(dir, devaddr, fcnt, i, sob);
+		lrw_encrypt_sob(tfm, sob);
+		for (j = 0; (i * LRW_SEQUENCE_OF_BLOCK_LEN + j) < len; j++)
+			buf[i * LRW_SEQUENCE_OF_BLOCK_LEN + j] ^= sob[j];
+	}
+
+	return 0;
+}
+
+int
+lrw_decrypt_buf(struct crypto_sync_skcipher *tfm,
+		u8 dir, u32 devaddr, u32 fcnt, u8 *buf, size_t len)
+{
+	/* According to XOR swap algorithm */
+	return lrw_encrypt_buf(tfm, dir, devaddr, fcnt, buf, len);
+}
+
+void
+lrw_aes_enc_key_free(struct crypto_sync_skcipher *tfm)
+{
+	crypto_free_sync_skcipher(tfm);
+}
+
+void
+lrw_encrypt_key_free(struct crypto_sync_skcipher *tfm)
+{
+	lrw_aes_enc_key_free(tfm);
+}
diff --git a/net/maclorawan/crypto.h b/net/maclorawan/crypto.h
new file mode 100644
index 000000000000..22dd810040c0
--- /dev/null
+++ b/net/maclorawan/crypto.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause */
+/*-
+ * LoRaWAN soft MAC
+ *
+ * Copyright (c) 2018 Jian-Hong, Pan <starnight@g.ncu.edu.tw>
+ *
+ */
+
+#ifndef __LORAWAN_CRYPTO_H__
+#define __LORAWAN_CRYPTO_H__
+
+#include <crypto/hash.h>
+#include <crypto/skcipher.h>
+
+struct crypto_shash *lrw_mic_key_setup(u8 *k, size_t k_len);
+int lrw_calc_mic(struct crypto_shash *tfm,
+		 u8 dir, u32 devaddr, u32 fcnt, u8 *buf, size_t len, u8 *mic4);
+void lrw_mic_key_free(struct crypto_shash *tfm);
+
+struct crypto_sync_skcipher *lrw_encrypt_key_setup(u8 *k, size_t k_len);
+int lrw_encrypt_buf(struct crypto_sync_skcipher *tfm,
+		    u8 dir, u32 devaddr, u32 fcnt, u8 *buf, size_t len);
+int lrw_decrypt_buf(struct crypto_sync_skcipher *tfm,
+		    u8 dir, u32 devaddr, u32 fcnt, u8 *buf, size_t len);
+void lrw_encrypt_key_free(struct crypto_sync_skcipher *tfm);
+
+#endif
-- 
2.20.0
