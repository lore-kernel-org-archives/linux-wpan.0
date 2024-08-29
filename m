Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EA5192B84;
	Thu, 29 Aug 2024 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724947859; cv=none; b=m+YdGzRsgak2zhX4RG5R1uDGn7HXNymOB5/Hp3QLT9mnbIybuxx92G8uKDYzbH16px2AX8m8c4SMfCo6iDHR5aQHdIexhigqdcRdaZ6FdlAGPuGbYhCIcU0Zq3fybEBWHpieGHzf6ZGMFq4U2jjPXlg1W7acxcqJ5Poxuj8YoS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724947859; c=relaxed/simple;
	bh=aFvzCKmbschf6lZtF17AymSYMQEpnIf1Ib8KpnDMrBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sUKd5OP+EV4V70cWvFyG1ceItcqryZoNB+0a6JlxBgn1EgGffSvoXHorBjBz2EIMgrT36FXsqDWGZwXOAYiwiwGpaT1d57IKX4dsO9R8kZ0BR6vvjdG3kTqN3menLAzRrugeGl7sv0SktUwKuGiJqgmU+vPAIVrl8OfYMtOmCgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWnAYRpd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWnAYRpd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A5CC4CEC5;
	Thu, 29 Aug 2024 16:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724947859;
	bh=aFvzCKmbschf6lZtF17AymSYMQEpnIf1Ib8KpnDMrBI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MWnAYRpdjrU29kby6jvnf+8EgOSlLNb2IFm/qgjdIVEgMfIUbafEfjiHWpF25bcS8
	 Fl2l/SAOW5cON9lpVSWfpqti2hnkYYJdXyo9FU2rvRK4KWqfvUgaCEb6+sfX/b+d/h
	 wfuJ+0NIfkDKpvl4KCpj8FipZks2lfS9r0ttisrzVKjQW1yR/uHriOk8DTgcnSUpLg
	 nlEqLIOOtgiuw4ETScwo3S3nHRY54Eq4SvwO9AZ2XYkjvRkI7iLI/Hxa3/5zIBfQTa
	 go/H3ypAMoQYgreZ9vUhjM8EnFP+Uyl6Ze3lOig6ZG7+u8YQhuUj6JzE5OgECiVCsQ
	 HTfzrpT8XlZBw==
From: Simon Horman <horms@kernel.org>
Date: Thu, 29 Aug 2024 17:10:50 +0100
Subject: [PATCH wpan-next 2/2] ieee802154: Correct spelling in nl802154.h
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-wpan-spell-v1-2-799d840e02c4@kernel.org>
References: <20240829-wpan-spell-v1-0-799d840e02c4@kernel.org>
In-Reply-To: <20240829-wpan-spell-v1-0-799d840e02c4@kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, 
 Stefan Schmidt <stefan@datenfreihafen.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, linux-wpan@vger.kernel.org, 
 netdev@vger.kernel.org
X-Mailer: b4 0.14.0

Correct spelling in nl802154.h.
As reported by codespell.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 include/net/nl802154.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/nl802154.h b/include/net/nl802154.h
index 4c752f799957..a994dea74596 100644
--- a/include/net/nl802154.h
+++ b/include/net/nl802154.h
@@ -192,7 +192,7 @@ enum nl802154_iftype {
  * @NL802154_CAP_ATTR_TX_POWERS: a nested attribute for
  *	nl802154_wpan_phy_tx_power
  * @NL802154_CAP_ATTR_MIN_CCA_ED_LEVEL: minimum value for cca_ed_level
- * @NL802154_CAP_ATTR_MAX_CCA_ED_LEVEL: maxmimum value for cca_ed_level
+ * @NL802154_CAP_ATTR_MAX_CCA_ED_LEVEL: maximum value for cca_ed_level
  * @NL802154_CAP_ATTR_CCA_MODES: nl802154_cca_modes flags
  * @NL802154_CAP_ATTR_CCA_OPTS: nl802154_cca_opts flags
  * @NL802154_CAP_ATTR_MIN_MINBE: minimum of minbe value

-- 
2.45.2

