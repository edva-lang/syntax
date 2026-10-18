import React, { FC, ReactNode, useEffect } from 'react';

export interface ModalProps {
  isOpen: boolean;
  title: string;
  onClose: () => void;
  children: ReactNode;
}

export const Modal: FC<ModalProps> = ({ isOpen, title, onClose, children }) => {
  useEffect(() => {
    const handleKeydown = (e: KeyboardEvent) => {
      if (e.key === 'Escape') onClose();
    };
    if (isOpen) {
      window.addEventListener('keydown', handleKeydown);
    }
    return () => window.removeEventListener('keydown', handleKeydown);
  }, [isOpen, onClose]);

  if (!isOpen) return null;

  return (
    <div className="modal-backdrop" role="dialog" aria-modal="true">
      <div className="modal-window">
        <header className="modal-header">
          <h2>{title}</h2>
          <button onClick={onClose} aria-label="Close">&times;</button>
        </header>
        <div className="modal-content">{children}</div>
      </div>
    </div>
  );
};
