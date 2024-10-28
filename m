Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B00C1DE8B3;
	Mon, 28 Oct 2024 16:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133410; cv=none; b=QVEHdulhULYz9c5TjTMB6T63dRflpVdFNxILtyrbYqBDmaB2Fv4wJEBevElVxZxOxGamVMXRZh1DOCQLVI8xK3jgAM8iPnJ4hkLjmmIr6cSMpzYEmptY5NY9uJiTyYKVIGHq5ZAB/whHtgsWm4B+3geZ0mQnZCjZ4iwK4uBJd78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133410; c=relaxed/simple;
	bh=bUP6fDetm4BEdNdBbdqYhqnqTS+NEpIDafsj0e1Z+BE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SpPANpddYInkmt3hdvzpjFJ0kDM5zxge5djebzlFbOVFsTldG8K7ELOU8NlcS2o4xODo2nUWNkiypoPdSP5wUgxJJ6a1+ezmkTYkzrc44U0sQdcPK3+qUg4Ia6w4NM3TeX6/NAiGO/P+puUzvB1PodvrCJEBg+NSXVk/uXJtkLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from localhost.localdomain (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 566C8C06F3;
	Mon, 28 Oct 2024 17:36:43 +0100 (CET)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	corbet@lwn.net,
	Leo Stone <leocstone@gmail.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	anupnewmail@gmail.com
Subject: Re: [PATCH net] Documentation: ieee802154: fix grammar
Date: Mon, 28 Oct 2024 17:35:52 +0100
Message-ID: <173013328919.2005465.16226848141693976566.b4-ty@datenfreihafen.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241023041203.35313-1-leocstone@gmail.com>
References: <20241023041203.35313-1-leocstone@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello Leo Stone.

On Tue, 22 Oct 2024 21:12:01 -0700, Leo Stone wrote:
> Fix grammar where it improves readability.
> 
> 

Applied to wpan/wpan-next.git, thanks!

[1/1] Documentation: ieee802154: fix grammar
      https://git.kernel.org/wpan/wpan-next/c/2107395f0711

regards,
Stefan Schmidt
